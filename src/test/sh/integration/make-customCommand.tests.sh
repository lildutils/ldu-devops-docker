#!/bin/bash

main() {
    CURRDIR=$(realpath $(dirname "${BASH_SOURCE[0]}")/)
    SRC=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../main/sh/)

    /bin/bash $SRC/make.sh echo hello-world
}

main
