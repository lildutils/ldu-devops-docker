_doDockerComposeUp() {
    __sonarqubeStartFix

    docker-compose \
        --project-name devops \
        --project-directory $DIR_DEVOPS \
        --file $DIR_DEVOPS/docker-compose.yml \
        up -d \
        --remove-orphans

    __downloadVscodeInstaller
}

__sonarqubeStartFix() {
    sysctl -w vm.max_map_count=262144
}

__downloadVscodeInstaller() {
    curl -sL "$FILE_DEVOPS_VSCODE_INSTALLER" -o $DIR_DEVOPS_DATA/vscode/install-vscode.sh
}
