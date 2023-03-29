#!/bin/bash

main() {
    build=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../../build/)
    runner=$build/make.sh

    if [ "$1" = "" ] | [ "$1" = "all" ]; then
        testCustomTask_ok
        testHelpTask_ok
    else
        cmd=$1
        shift
        $cmd $*
    fi
}

testCustomTask_ok() {
    /bin/bash $runner echo hello-world
}

testHelpTask_ok() {
    /bin/bash $runner help
    /bin/bash $runner --help
}

main $*
