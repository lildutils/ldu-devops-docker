_doDockerComposeUp() {
    docker-compose \
        --project-name devops \
        --project-directory $DIR_DEVOPS \
        --file $DIR_DEVOPS/docker-compose.yml \
        up -d \
        --remove-orphans

    __downloadVscodeInstaller
}


__downloadVscodeInstaller() {
    curl -sL "$FILE_DEVOPS_VSCODE_INSTALLER" -o $DIR_DEVOPS_DATA/vscode/install-vscode.sh
}
