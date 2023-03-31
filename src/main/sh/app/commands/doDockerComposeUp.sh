_doDockerComposeUp() {
    docker-compose \
        --project-name devops \
        --project-directory $DIR_DEVOPS \
        --file $DIR_DEVOPS/docker-compose.yml \
        up -d \
        --remove-orphans
}
