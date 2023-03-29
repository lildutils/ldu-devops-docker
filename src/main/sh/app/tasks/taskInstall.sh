install() {
    _doInstallTools

    _doInstallDocker
    _doInstallDockerCompose

    _doInstallDevOps

    for mode in ${CRON_BACKUP_MODES//,/ }; do
        _doInstallCron "$mode"
    done

    _doDockerComposeUp

    _doGarbageCollect
    _doTerminalClean
}
