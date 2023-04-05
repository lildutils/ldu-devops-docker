#!/bin/bash

main() {
    cmd=$1
    rootDir=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../../)
    build=$(realpath $(dirname "${BASH_SOURCE[0]}")/../../../../build)
    runner=$build/make.sh

    if [ "$cmd" = "" ]; then
        testCustomTask_ok
        testHelpTask_ok
    else
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

#Disabled
testDockerCompose_ok() {
    rm -rf $rootDir/.tmp/
    mkdir $rootDir/.tmp/

    cp $build/res/docker-compose.env $rootDir/.tmp/.env
    cp $build/res/docker-compose.yml $rootDir/.tmp/docker-compose.yml

    nano $rootDir/.tmp/.env
    docker-compose \
        --file $rootDir/.tmp/docker-compose.yml \
        --project-directory $rootDir/.tmp/ \
        up -d
}

main $*
