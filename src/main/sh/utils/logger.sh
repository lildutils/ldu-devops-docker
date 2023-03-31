if [ "$1" = "logDebug" ]; then
    shift
    echo $(date +"%Y-%m-%d %H:%M:%S.%s") [DEBUG] $*
fi
if [ "$1" = "logInfo" ]; then
    shift
    echo $(date +"%Y-%m-%d %H:%M:%S.%s") [ INFO] $*
fi
