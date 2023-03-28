#!/bin/bash

main() {
    COMMAND=$1
    CURRDIR=$(realpath $(dirname "${BASH_SOURCE[0]}")/)
    INIFILE=$(realpath $(dirname "${BASH_SOURCE[0]}")/make.ini)
    if [ -f $INIFILE ]; then export $(cat $INIFILE | xargs); fi
    shift
    $COMMAND $*
    exit 0
}

install() {
    _doInstallTools
    _doInstallDocker
    _doInstallDockerCompose
    _doInstallDevOps
    _doDockerComposeUp
    _doDockerGCC
    #_doTerminalClean
}

backup() {
    currentBackups=$DIR_DEVOPS_BACKUPS/$(echo $(date +"%Y%m%d%H%M%S"))

    devopsBackups=$currentBackups/devops/docker
    nginxBackups=$currentBackups/nginx/configs
    portainerBackups=$currentBackups/portainer/exports
    dbBackups=$currentBackups/db/dumps

    mkdir -p $devopsBackups/
    mkdir -p $nginxBackups/
    mkdir -p $portainerBackups/
    mkdir -p $dbBackups/

    ## devops
    cp -r $DIR_DEVOPS/.env $devopsBackups/docker-compose.env.backup
    cp -r $DIR_DEVOPS/docker-compose.yml $devopsBackups/docker-compose.yml.backup

    ## TODO: nginx

    ## TODO: portainer

    ## TODO: databases

    _doTerminalClean
}

clean() {
    _doDockerClean

    rm -rf $DEVOPS_DATA_DIR/
    rm -rf $DEVOPS_ROOT_DIR/

    _doTerminalClean
}

registerGitlabRunner() {
    docker exec -it gitlabrunner \
        gitlab-runner register --non-interactive \
        --registration-token $GITLAB_RUNNER_REGISTRATION_TOKEN \
        --name docker-gitlab-runner \
        --url http://gitlab \
        --tag-list docker,docker-stable \
        --executor docker \
        --docker-image docker:stable

    _doTerminalClean
}

_doInstallTools() {
    apt-get update -y
    apt-get full-upgrade -y
    apt-get autoremove -y

    apt-get install -y curl htop mc nano net-tools ufw fail2ban

    systemctl start ufw
    systemctl enable ufw
    ufw enable
    ufw default deny incoming
    ufw default deny outgoing
    for rule in ${UFW_ALLOW_IN//,/ }; do
        ufw allow in $rule
    done
    for rule in ${UFW_ALLOW_OUT//,/ }; do
        ufw allow out $rule
    done
    ufw reload

    systemctl start fail2ban
    systemctl enable fail2ban
    echo "[sshd]" >/etc/fail2ban/jail.local
    echo "enabled = true" >>/etc/fail2ban/jail.local
    echo "port = 22" >>/etc/fail2ban/jail.local
    echo "filter = sshd" >>/etc/fail2ban/jail.local
    echo "logpath = /var/log/auth.log" >>/etc/fail2ban/jail.local
    echo "maxretry = $FAIL2BAN_MAX_RETRY" >>/etc/fail2ban/jail.local
    systemctl restart fail2ban
}

_doInstallDocker() {
    mkdir -p ./tmp/
    curl -sL "https://get.docker.com" -o ./tmp/install-docker.sh
    chmod 755 ./tmp/install-docker.sh
    /bin/sh ./tmp/install-docker.sh
    rm -rf ./tmp/install-docker.sh
}

_doInstallDockerCompose() {
    apt-get install -y docker-compose
}

_doInstallDevOps() {
    if [ ! -d "$DIR_DEVOPS/" ]; then mkdir -p $DIR_DEVOPS/; fi
    if [ ! -d "$DIR_DEVOPS_BACKUPS/" ]; then mkdir -p $DIR_DEVOPS_BACKUPS/; fi
    if [ ! -d "$DIR_DEVOPS_DATA/" ]; then mkdir -p $DIR_DEVOPS_DATA/; fi

    rm -rf $DIR_DEVOPS/docker-compose.env
    rm -rf $DIR_DEVOPS/docker-compose.yml

    if [ ! -f $DIR_DEVOPS/.env ]; then
        curl -sL "$FILE_DEVOPS_ENV" -o $DIR_DEVOPS/docker-compose.env
        nano $DIR_DEVOPS/docker-compose.env
        cp $DIR_DEVOPS/docker-compose.env $DIR_DEVOPS/.env
        cp rm -rf $DIR_DEVOPS/docker-compose.env
    fi
    curl -sL "$FILE_DEVOPS_COMPOSE" -o $DIR_DEVOPS/docker-compose.yml
}

_doDockerComposeUp() {
    _doDockerComposeUpPre

    docker-compose \
        --project-name devops \
        --project-directory $DIR_DEVOPS \
        --file $DIR_DEVOPS/docker-compose.yml \
        up -d \
        --remove-orphans

    _doDockerComposeUpPost
}

_doDockerComposeUpPre() {
    if [ -f $DIR_DEVOPS/.env ]; then export $(cat $DIR_DEVOPS/.env | xargs); fi

    for dbClient in ${DOCKER_INIT_DB_CLIENTS//,/ }; do
        docker-compose --project-name devops --project-directory $DIR_DEVOPS --file $DIR_DEVOPS/docker-compose.yml up -d $dbClient

        if [ "$dbClient" == "phpmyadmin" ]; then
            mkdir -p ./tmp/

            echo "CREATE USER '$PROXYMNGR_DB_USER'@'%' IDENTIFIED BY '$PROXYMNGR_DB_PASSWORD';" >./tmp/mysql-init.sql
            echo "CREATE DATABASE proxymanager;" >>./tmp/mysql-init.sql
            echo "GRANT ALL PRIVILEGES ON proxymanager.* TO '$PROXYMNGR_DB_USER'@'%';" >>./tmp/mysql-init.sql

            sleep 30 # TODO: wait for service 'mysql' has started, avoid sleep
            docker exec -i mysql sh -c "exec mysql -u$MYSQL_ROOT_USER -p'$MYSQL_ROOT_PASSWORD'" <./mysql-init.sql

            rm -rf ./mysql-init.sql
        fi

        if [ "$dbClient" == "pgadmin" ]; then
            mkdir -p ./tmp/

            echo "CREATE ROLE $SONARQUBE_SONAR_USER WITH LOGIN NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION PASSWORD '$SONARQUBE_SONAR_PASSWORD';" >./tmp/postgres-init.sql
            echo "CREATE DATABASE sonar WITH OWNER = sonar;" >>./tmp/postgres-init.sql
            echo "GRANT ALL PRIVILEGES ON DATABASE sonar TO $SONARQUBE_SONAR_USER;" >>./tmp/postgres-init.sql

            sleep 30 # TODO: wait for service 'postgres' has started, avoid sleep
            docker exec -i postgres sh -c "exec psql -u$POSTGRES_ROOT_USER -p$POSTGRES_ROOT_PASSWORD" <./tmp/postgres-init.sql

            rm -rf ./tmp/init-postgres.sql
        fi
    done
}

_doDockerComposeUpPost() {
    docker --version
    docker-compose --version
}

_doDockerGCC() {
    echo y | docker system prune
}

_doDockerClean() {
    docker container kill $(docker container ls -aq)
    docker container rm --force $(docker container ls -aq)
    docker volume rm --force $(docker volume ls -aq)
    docker image rm --force $(docker image ls -aq)
    docker network rm --force $(docker network ls -aq)
}

_doTerminalClean() {
    rm -rf ~/.cache/ ~/.config/ ~/.docker/ ~/.gnupg/ ~/.local/ ~/.nano/ ~/.bash_history ~/.selected_editor ~/.sudo_as_admin_successful
    history -c
    clear
}

main $*
