#!/bin/bash

main() {
    if [ "$1" = "" ] | [ "$1" = "all" ]; then
        ## unit tests here
    else
        cmd=$1
        shift
        $cmd $*
    fi
}

main $*
