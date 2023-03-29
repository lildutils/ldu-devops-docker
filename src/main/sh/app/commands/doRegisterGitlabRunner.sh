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
