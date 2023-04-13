_doInstallDocker() {
    mkdir -p $DIR_DEVOPS/.tmp/

    curl -sL "https://get.docker.com" -o $DIR_DEVOPS/.tmp/install-docker.sh

    chmod 755 $DIR_DEVOPS/.tmp/install-docker.sh
    /bin/sh $DIR_DEVOPS/.tmp/install-docker.sh
    rm -rf $DIR_DEVOPS/.tmp/install-docker.sh

    docker --version
}
