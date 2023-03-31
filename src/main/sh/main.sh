main() {
    TASK=$1

    ## default task = install
    if [ "$1" == "" ]; then TASK=install; fi

    ## check task
    if [ "$TASK" == "--help" ]; then TASK=help; fi

    ## load default environment
    CURRDIR=$(realpath $(dirname "${BASH_SOURCE[0]}")/)
    ## main.ini
    CRON_BACKUP_INSTANCES=devops,portainer,mongodb,mysql,postgres,vscode,nginx,gitlab,sonarqube,registry
    CRON_BACKUP_MODES=daily,weekly,monthly
    DIR_DEVOPS=/devops
    DIR_DEVOPS_BACKUPS=/backups
    DIR_DEVOPS_DATA=/data
    FAIL2BAN_MAX_RETRY=3
    FILE_DEVOPS_ENV=https://raw.githubusercontent.com/lildutils/ldu-devops-docker/master/dist/latest/resources/docker-compose.env
    FILE_DEVOPS_COMPOSE=https://raw.githubusercontent.com/lildutils/ldu-devops-docker/master/dist/latest/resources/docker-compose.yml
    FILE_DEVOPS_MAKE=https://raw.githubusercontent.com/lildutils/ldu-devops-docker/master/dist/latest/make.sh
    INIFILENAME=make
    MAKEFILENAME=make
    UFW_ALLOW_IN=http,https,ssh
    UFW_ALLOW_OUT=http,https,53,631

    ## load docker environment if .env file exists
    if [ -f "$DIR_DEVOPS/.env" ]; then export $(cat "$DIR_DEVOPS/.env" | xargs); fi

    ## override environment if .ini file exists
    if [ -f "$CURRDIR/$INIFILENAME.ini" ]; then export $(cat "$CURRDIR/$INIFILENAME.ini" | xargs); fi

    ## run
    shift
    $TASK $*
    exit 0
}
