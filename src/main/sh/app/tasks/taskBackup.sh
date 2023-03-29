backup() {
    currentBackups=$DIR_DEVOPS_BACKUPS/$(echo $(date +"%Y%m%d%H%M%S"))

    for instance in ${CRON_BACKUP_INSTANCES//,/ }; do
        if [ "$instance" = "devops" ]; then
            _doBackupDevOPS
        fi
        if [ "$instance" = "portainer" ]; then
            _doBackupPortainer
        fi
        if [ "$instance" = "mongodb" ]; then
            _doBackupMongoDB
        fi
        if [ "$instance" = "mysql" ]; then
            _doBackupMySQL
        fi
        if [ "$instance" = "postgres" ]; then
            _doBackupPostgres
        fi
        if [ "$instance" = "vscode" ]; then
            _doBackupCodeServer
        fi
        if [ "$instance" = "nginx" ]; then
            _doBackupNginx
        fi
        if [ "$instance" = "gitlab" ]; then
            _doBackupGitlab
        fi
        if [ "$instance" = "sonarqube" ]; then
            _doBackupSonarQube
        fi
        if [ "$instance" = "registry" ]; then
            _doBackupDockerRegistry
        fi
    done

    _doDockerGarbageCollect
    _doTerminalClean
}
