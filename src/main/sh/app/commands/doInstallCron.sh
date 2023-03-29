_doInstallCron() {
    if [ "$1" == "daily" ]; then scheduler='0 4 * * *'; fi
    if [ "$1" == "weekly" ]; then scheduler='0 5 * * 1'; fi
    if [ "$1" == "monthly" ]; then scheduler='0 6 1 * *'; fi

    crontab -l >cronjobs
    echo "$scheduler $DIR_DEVOPS/$MAKEFILENAME backup>/dev/null 2>&1" >>cronjobs
    crontab cronjobs
    rm cronjobs
    crontab -l
}
