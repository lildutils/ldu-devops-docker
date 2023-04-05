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
