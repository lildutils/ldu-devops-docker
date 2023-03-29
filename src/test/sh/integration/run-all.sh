#!/bin/bash

main() {
    CURR_DIR=$(realpath $(dirname "${BASH_SOURCE[0]}")/)

    /bin/bash $CURR_DIR/application-integration.tests.sh $*
}

main $*
