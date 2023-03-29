#!/bin/bash

main() {
    if [ "$1" = "" ] | [ "$1" = "all" ]; then
        testEchoCommaSeparatedVariable_ok
        testDeleteTmpFileAfterCopyAndContinueRun_ok
    else
        cmd=$1
        shift
        $cmd $*
    fi
}

testEchoCommaSeparatedVariable_ok() {
    UFW_ALLOW_IN=http,https,ssh
    for rule in ${UFW_ALLOW_IN//,/ }; do
        echo "$rule"
    done

    UFW_ALLOW_OUT=http,https,53/udp
    for rule in ${UFW_ALLOW_OUT//,/ }; do
        echo "$rule"
    done
}

testDeleteTmpFileAfterCopyAndContinueRun_ok() {
    echo "deleteme" >deleteme.txt
    cp deleteme.txt copied.txt
    rm -rf deleteme.txt
    echo "after deleted txt"
    read -s -n 1 -p "Press any key to continue..." && printf "\n"
    rm -rf copied.txt
}

main $*
