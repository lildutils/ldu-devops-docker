_doInstallDockerCompose() {
    apt-get install -y docker-compose

    docker-compose --version
}
