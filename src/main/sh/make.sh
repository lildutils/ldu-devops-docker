#!/bin/bash

main() {
    COMMAND=$1
    CURRDIR=$(realpath $(dirname "${BASH_SOURCE[0]}")/)
    INIFILE=$(realpath $(dirname "${BASH_SOURCE[0]}")/make.ini)
    if [ -f $INIFILE ]; then export $(cat $INIFILE | xargs); fi
    shift
    CURRUSER=$USER
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
}

clean() {
    _doDockerClean

    rm -rf $DEVOPS_DATA_DIR/
    rm -rf $DEVOPS_ROOT_DIR/
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
    ufw allow ssh
    ufw allow http
    ufw allow https
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
    fi
    curl -sL "$FILE_DEVOPS_COMPOSE" -o $DIR_DEVOPS/docker-compose.yml
}

_doDockerComposeUp() {
    su docker
    docker-compose --project-name devops --project-directory $DIR_DEVOPS --file $DIR_DEVOPS/docker-compose.yml up -d --remove-orphans
    su $CURRUSER
}

_doDockerGCC() {
    docker system prune
}

_doDockerClean() {
    docker container kill $(docker container ls -aq)
    docker container rm --force $(docker container ls -aq)
    docker volume rm --force $(docker volume ls -aq)
    docker image rm --force $(docker image ls -aq)
    docker network rm --force $(docker network ls -aq)
}

main $*