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

#@Disabled#
testDockerCompose_ok() {
    ## clean
    rm -rf $rootDir/.tmp/
    mkdir $rootDir/.tmp/
    ## copy docker-compose
    cp $build/res/docker-compose.env $rootDir/.tmp/.env
    cp $build/res/docker-compose.yml $rootDir/.tmp/docker-compose.yml
    ## prepare docker dotenv
    nano $rootDir/.tmp/.env
    ## docker-compose
    docker-compose \
        --file $rootDir/.tmp/docker-compose.yml \
        --project-directory $rootDir/.tmp/ \
        up -d $service
}

#@Disabled#
testDockerComposeVSCode_ok() {
    service=vscode
    ## clean
    rm -rf $rootDir/.tmp/
    mkdir $rootDir/.tmp/
    ## copy docker-compose
    cp $build/res/docker-compose.env $rootDir/.tmp/.env
    cp $build/res/docker-compose.yml $rootDir/.tmp/docker-compose.yml
    ## copy script
    cp $build/bin/install-vscode.sh $rootDir/.tmp/install-vscode.sh
    ## prepare docker dotenv
    nano $rootDir/.tmp/.env
    ## docker-compose
    docker-compose \
        --file $rootDir/.tmp/docker-compose.yml \
        --project-directory $rootDir/.tmp/ \
        up -d $service
    ## run
    docker cp $service:/config/install-vscode.sh $rootDir/.tmp/install-vscode.sh
    docker exec -it $service bash \
        -c "chmod 755 /config/install-vscode.sh && /bin/sh /config/install-vscode.sh"
}

main $*
