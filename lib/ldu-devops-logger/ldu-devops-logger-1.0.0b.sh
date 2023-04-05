#!/bin/sh

main() {
    if [ "$1" = "logTrace" ]; then
        shift
        echo $(date +"%Y-%m-%d %H:%M:%S.%s") [TRACE] $*
    fi
    if [ "$1" = "logDebug" ]; then
        shift
        echo $(date +"%Y-%m-%d %H:%M:%S.%s") [DEBUG] $*
    fi
    if [ "$1" = "logInfo" ]; then
        shift
        echo $(date +"%Y-%m-%d %H:%M:%S.%s") [ INFO] $*
    fi
    if [ "$1" = "logWarn" ]; then
        shift
        echo $(date +"%Y-%m-%d %H:%M:%S.%s") [ WARN] $*
    fi
    if [ "$1" = "logError" ]; then
        shift
        echo $(date +"%Y-%m-%d %H:%M:%S.%s") [ERROR] $*
    fi
}

main $*
