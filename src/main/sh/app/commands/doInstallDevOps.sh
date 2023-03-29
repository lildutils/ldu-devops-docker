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

    if [ -f "$CURRDIR/$MAKEFILENAME" ]; then
        cp $CURRDIR/$MAKEFILENAME $DIR_DEVOPS/
    else
        curl -sL "$FILE_DEVOPS_MAKE" -o $DIR_DEVOPS/$MAKEFILENAME
        chmod 755 $DIR_DEVOPS/$MAKEFILENAME
    fi
}
