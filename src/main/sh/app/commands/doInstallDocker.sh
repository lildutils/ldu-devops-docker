_doInstallDocker() {
    mkdir -p ./tmp/

    curl -sL "https://get.docker.com" -o ./tmp/install-docker.sh

    chmod 755 ./tmp/install-docker.sh
    /bin/sh ./tmp/install-docker.sh
    rm -rf ./tmp/install-docker.sh

    docker --version
}
