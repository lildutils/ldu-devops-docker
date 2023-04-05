main() {
    TASK=$1

    ## default task
    if [ "$1" == "" ]; then TASK=install; fi

    ## check help
    if [ "$TASK" == "--help" ] | [ "$TASK" == "-h" ]; then TASK=help; fi

    ## load default environment
    CURRDIR=$(realpath $(dirname "${BASH_SOURCE[0]}")/)
    CURRFILE=$0

    ## load docker environment if .env file exists
    if [ -f "$DIR_DEVOPS/.env" ]; then export $(cat "$DIR_DEVOPS/.env" | xargs); fi

    ## override environment if .ini file exists
    if [ -f "$CURRDIR/$CURRFILE.ini" ]; then export $(cat "$CURRDIR/$CURRFILE.ini" | xargs); fi

    ## run
    shift
    $TASK $*
    exit 0
}
