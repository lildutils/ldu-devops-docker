_doBackupDevOPS() {
    currentBackupDir=$currentBackups/devops

    mkdir -p $currentBackupDir/

    cp $DIR_DEVOPS/.env $currentBackupDir/docker-compose.env.backup
    cp $DIR_DEVOPS/docker-compose.yml $currentBackupDir/docker-compose.yml.backup
}
