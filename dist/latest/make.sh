####################
#!/bin/bash

CRON_BACKUP_MODES=weekly,monthly
CRON_BACKUP_SERVICES=devops,portainer,nginx
DEBUG_MODE=FALSE
DEVOPS_SERVICES=portainer,nginx
DIR_DEVOPS=/devops
DIR_DEVOPS_BACKUPS=/backups
DIR_DEVOPS_DATA=/data
FAIL2BAN_MAX_RETRY=3
FILE_DEVOPS_ENV=https://raw.githubusercontent.com/lildutils/ldu-devops-docker/master/dist/latest/res/docker-compose.env
FILE_DEVOPS_COMPOSE=https://raw.githubusercontent.com/lildutils/ldu-devops-docker/master/dist/latest/res/docker-compose.yml
FILE_DEVOPS_MAKE=https://raw.githubusercontent.com/lildutils/ldu-devops-docker/master/dist/latest/make.sh
UFW_ALLOW_IN=80,443,22
UFW_ALLOW_OUT=80,443,53,631

####################
# main

main() {
    TASK=$1

    ## default task
    if [ "$1" == "" ]; then TASK=install; fi

    ## check help
    if [ "$TASK" == "--help" ] | [ "$TASK" == "-h" ]; then TASK=help; fi

    ## load default environment
    CURRDIR=$(realpath $(dirname "${BASH_SOURCE[0]}")/)
    CURRFILE=$0

    ## load docker environment if .env file exists
    if [ -f "$DIR_DEVOPS/.env" ]; then export $(cat "$DIR_DEVOPS/.env" | xargs); fi

    ## override environment if .ini file exists
    if [ -f "$CURRDIR/$CURRFILE.ini" ]; then export $(cat "$CURRDIR/$CURRFILE.ini" | xargs); fi

    ## run
    shift
    $TASK $*
    exit 0
}

####################
# tasks

backup() {
    currentBackups=$DIR_DEVOPS_BACKUPS/$(echo $(date +"%Y%m%d%H%M%S"))

    for instance in ${CRON_BACKUP_INSTANCES//,/ }; do
        if [ "$instance" = "devops" ]; then
            _doBackupDevOPS
        fi
        if [ "$instance" = "portainer" ]; then
            _doBackupPortainer
        fi
        if [ "$instance" = "mongodb" ]; then
            _doBackupMongoDB
        fi
        if [ "$instance" = "mysql" ]; then
            _doBackupMySQL
        fi
        if [ "$instance" = "postgres" ]; then
            _doBackupPostgres
        fi
        if [ "$instance" = "vscode" ]; then
            _doBackupCodeServer
        fi
        if [ "$instance" = "nginx" ]; then
            _doBackupNginx
        fi
        if [ "$instance" = "gitlab" ]; then
            _doBackupGitlab
        fi
        if [ "$instance" = "sonarqube" ]; then
            _doBackupSonarQube
        fi
        if [ "$instance" = "registry" ]; then
            _doBackupDockerRegistry
        fi
    done

    _doDockerGarbageCollect
    _doTerminalClean
}

registerGitlabRunner() {
    _doRegisterGitlabRunner
    _doDockerGarbageCollect
    _doTerminalClean
}

help() {
    echo "USAGE"
    echo "  make.sh <task|--help> [<args>]"
    echo "  "
    echo "tasks:"
    echo "  install               --  make a full devops (re)install"
    echo "  backup                --  make configured backup modes"
    echo "  clean                 --  make a full devops and docker clean, expect /backups"
    echo "  registerGitlabRunner  --  register a gitlab runner into gitlab by configured GITLAB_RUNNER_TOKEN"
    echo "  <customTask>          --  run any custom unix command in terminal"
    echo "  "
    echo "args:"
    echo "  GITLAB_RUNNER_TOKEN   --  runner token from gitlab"
    echo "  customArgs            --  custom arguments for any <customTask>"
    echo "  "
}

install() {
    _doInstallTools

    _doInstallDocker
    _doInstallDockerCompose

    _doInstallDevOps

    for mode in ${CRON_BACKUP_MODES//,/ }; do
        _doInstallCron "$mode"
    done

    for service in ${DEVOPS_SERVICES//,/ }; do
        _doDockerComposeUp "$service"
    done

    _doDockerGarbageCollect
    _doTerminalClean
}

clean() {
    _doDockerClean

    _doRemoveFolder "$DEVOPS_DATA_DIR/"
    _doRemoveFolder "$DEVOPS_ROOT_DIR/"

    _doDockerGarbageCollect
    _doTerminalClean
}

####################
# commands

_doBackupDevOPS() {
    currentBackupDir=$currentBackups/devops

    mkdir -p $currentBackupDir/

    cp $DIR_DEVOPS/.env $currentBackupDir/docker-compose.env.backup
    cp $DIR_DEVOPS/docker-compose.yml $currentBackupDir/docker-compose.yml.backup
}

_doTerminalClean() {
    read -s -n 1 -p "Press any key to continue..." && printf "\n"

    rm -rf ~/.cache/ ~/.config/ ~/.docker/ ~/.gnupg/ ~/.local/ ~/.nano/ ~/.bash_history ~/.selected_editor ~/.sudo_as_admin_successful

    history -c
    clear
}

_doDockerGarbageCollect() {
    echo y | docker system prune
}

_doBackupGitlab() {
    currentBackupDir=$currentBackups/gitlab

    mkdir -p $currentBackupDir/

    ## TODO: backup gitlab
}

_doBackupPortainer() {
    currentBackupDir=$currentBackups/portainer

    mkdir -p $currentBackupDir/

    ## TODO: backup portainer
}

_doDockerClean() {
    docker container kill --force $(docker container ls -aq)
    docker container rm --force $(docker container ls -aq)
    docker volume rm --force $(docker volume ls -aq)
    docker image rm --force $(docker image ls -aq)
    docker network prune --force
}

_doBackupMongoDB() {
    currentBackupDir=$currentBackups/db/mongodb

    mkdir -p $currentBackupDir/

    ## TODO: backup mongodb
}

_doRegisterGitlabRunner() {
    docker exec -it gitlabrunner \
        gitlab-runner register \
        --non-interactive \
        --registration-token $GITLAB_RUNNER_REGISTRATION_TOKEN \
        --name docker-gitlab-runner \
        --url http://gitlab \
        --tag-list docker,docker-stable \
        --executor docker \
        --docker-image docker:stable
}

_doBackupCodeServer() {
    currentBackupDir=$currentBackups/vscode

    mkdir -p $currentBackupDir/

    ## TODO: backup vscode
}

_doInstallDocker() {
    mkdir -p ./tmp/

    curl -sL "https://get.docker.com" -o ./tmp/install-docker.sh

    chmod 755 ./tmp/install-docker.sh
    /bin/sh ./tmp/install-docker.sh
    rm -rf ./tmp/install-docker.sh

    docker --version
}

_doBackupPostgres() {
    currentBackupDir=$currentBackups/db/postgres

    mkdir -p $currentBackupDir/

    ## TODO: backup postgres
}

_doInstallDevOps() {
    if [ ! -d "$DIR_DEVOPS/" ]; then
        mkdir -p $DIR_DEVOPS/
    fi
    if [ ! -d "$DIR_DEVOPS_BACKUPS/" ]; then
        mkdir -p $DIR_DEVOPS_BACKUPS/
    fi
    if [ ! -d "$DIR_DEVOPS_DATA/" ]; then
        mkdir -p $DIR_DEVOPS_DATA/
    fi

    rm -rf $DIR_DEVOPS/docker-compose.yml

    if [ ! -f $DIR_DEVOPS/.env ]; then
        curl -sL "$FILE_DEVOPS_ENV" -o $DIR_DEVOPS/.env
        nano $DIR_DEVOPS/.env
    fi

    curl -sL "$FILE_DEVOPS_COMPOSE" -o $DIR_DEVOPS/docker-compose.yml

    if [ -f "$CURRDIR/$CURRFILE.sh" ]; then
        cp $CURRDIR/$CURRFILE.sh $DIR_DEVOPS/
    else
        curl -sL "$FILE_DEVOPS_MAKE" -o $DIR_DEVOPS/$CURRFILE.sh
        chmod 755 $DIR_DEVOPS/$CURRFILE.sh
    fi
}

_doBackupNginx() {
    currentBackupDir=$currentBackups/nginx

    mkdir -p $currentBackupDir/

    ## TODO: backup nginx
}

_doDockerComposeUp() {
    $dockerComposeFile=docker-compose.yml
    $dockerComposeService=$1

    docker-compose \
        --project-name $dockerComposeService \
        --project-directory $DIR_DEVOPS \
        --file $DIR_DEVOPS/$dockerComposeFile \
        up -d $dockerComposeService

    if [ "$dockerComposeService" = "vscode" ]; then
        _doDockerComposeUpPostInstallVSCode
    fi
}

_doBackupDockerRegistry() {
    currentBackupDir=$currentBackups/registry

    mkdir -p $currentBackupDir/

    ## TODO: backup registry
}

_doInstallTools() {
    __doInstallToolsOSUpgrade
    __doInstallToolsDevTools
    __doInstallToolsUFW
    __doInstallToolsFail2ban
}

__doInstallToolsOSUpgrade() {
    apt-get update -y
    apt-get full-upgrade -y
    apt-get autoremove -y
}

__doInstallToolsDevTools() {
    apt-get install -y curl htop mc nano net-tools ufw fail2ban
}

__doInstallToolsUFW() {
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
}

__doInstallToolsFail2ban() {
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

_doBackupMySQL() {
    currentBackupDir=$currentBackups/db/mysql

    mkdir -p $currentBackupDir/

    ## TODO: backup mysql
}

_doDockerComposeUpPostInstallVSCode() {
    cmd="echo \"#!/bin/sh\">/config/install-vscode.sh"
    ## upgrade vscode
    cmd="$cmd ; echo \"apt update\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"apt full-upgrade -y\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"apt autoremove -y\">>/config/install-vscode.sh"
    ## install devtools
    cmd="$cmd ; echo \"apt-get install -y build-essential inotify-tools curl htop mc nano net-tools\">>/config/install-vscode.sh"
    ## install git
    cmd="$cmd ; echo \"apt-get install -y git git-flow\">>/config/install-vscode.sh"
    ## install docker
    cmd="$cmd ; echo \"curl -sL https://get.docker.com -o /config/install-docker.sh\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"chmod 755 /config/install-docker.sh\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"/bin/sh /config/install-docker.sh\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"rm -rf /config/install-docker.sh\">>/config/install-vscode.sh"
    ## install docker-compose
    cmd="$cmd ; echo \"apt-get install -y docker-compose\">>/config/install-vscode.sh"
    ## check versions
    cmd="$cmd ; echo \"echo \$(git --version)\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"echo git-flow version \$(git-flow version)\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"echo \$(docker --version)\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"echo \$(docker-compose --version)\">>/config/install-vscode.sh"
    ## check ownerships
    cmd="$cmd ; echo \"echo \$SUDO_USER, \$(id -u \$SUDO_USER):\$(id -g \$SUDO_USER)\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"chown -R \$SUDO_USER:\$SUDO_USER /works\">>/config/install-vscode.sh"

    sleep 5
    docker exec -i vscode bash -c "$cmd"
}

_doInstallCron() {
    if [ "$1" == "daily" ]; then scheduler='0 4 * * *'; fi
    if [ "$1" == "weekly" ]; then scheduler='0 5 * * 1'; fi
    if [ "$1" == "monthly" ]; then scheduler='0 6 1 * *'; fi

    crontab -l >cronjobs
    echo "$scheduler $DIR_DEVOPS/$CURRFILE.sh backup>/dev/null 2>&1" >>cronjobs
    crontab cronjobs
    rm cronjobs
    crontab -l
}

_doBackupSonarQube() {
    currentBackupDir=$currentBackups/sonarqube

    mkdir -p $currentBackupDir/

    ## TODO: backup sonarqube
}

_doInstallDockerCompose() {
    apt-get install -y docker-compose

    docker-compose --version
}

####################
# run

main $*
