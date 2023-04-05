install() {
    _doInstallTools

    _doInstallDocker
    _doInstallDockerCompose

    _doInstallDevOps

    for mode in ${CRON_BACKUP_MODES//,/ }; do
        _doInstallCron "$mode"
    done

    for service in ${DEVOPS_SERVICES//,/ }; do
        _doDockerComposeUp "$service"
    done

    _doDockerGarbageCollect
    _doTerminalClean
}
