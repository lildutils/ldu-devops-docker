#!/bin/bash

main() {
    currDir=$(realpath $(dirname "${BASH_SOURCE[0]}")/$1)

    tmpBinaries=$(realpath $(dirname "${BASH_SOURCE[0]}")/tmp/bin/)
    tmpResources=$(realpath $(dirname "${BASH_SOURCE[0]}")/tmp/resources/)

    logger=$(realpath $(dirname "${BASH_SOURCE[0]}")/lib/logger.sh)

    makeFile=$currDir/make.sh
    composeEnv=$currDir/res/docker-compose.env
    composeFile=$currDir/res/docker-compose.yml

    _compileMakeFile
    _compileComposeEnv
    _compileComposeFile
}

_logDebug() {
    /bin/sh $logger logDebug $*
}

_logInfo() {
    /bin/sh $logger logInfo $*
}

_compileMakeFile() {
    _logInfo compile... make file
    start=$(date +%s)

    _logDebug compile file: "'$makeFile'" create
    touch $makeFile

    _logDebug compile file: "'$makeFile'" main.pre
    echo "####################" >$makeFile
    echo "#!/bin/bash" >>$makeFile
    echo "" >>$makeFile
    echo "$(cat $tmpResources/default-environment.ini)" >>$makeFile
    echo "" >>$makeFile

    _logDebug compile file: "'$makeFile'" main
    echo "####################" >>$makeFile
    echo "# main" >>$makeFile
    echo "" >>$makeFile
    echo "$(cat $tmpBinaries/main.sh)" >>$makeFile
    echo "" >>$makeFile

    _logDebug compile file: "'$makeFile'" -- tasks
    echo "####################" >>$makeFile
    echo "# tasks" >>$makeFile
    echo "" >>$makeFile
    tasks=($(find "$tmpBinaries/" -name 'task*.sh' -exec echo "{}" \;))
    n=${#tasks[@]}
    for ((i = 0; i < ${n}; i++)); do
        task=${tasks[$i]}
        _logDebug compile file: "'$makeFile'" ---- task: "'$task'"
        echo "$(cat $task)" >>$makeFile
        echo "" >>$makeFile
    done

    _logDebug compile file: "'$makeFile'" -- commands
    echo "####################" >>$makeFile
    echo "# commands" >>$makeFile
    echo "" >>$makeFile
    commands=($(find "$tmpBinaries/" -name 'do*.sh' -exec echo "{}" \;))
    n=${#commands[@]}
    for ((i = 0; i < ${n}; i++)); do
        command=${commands[$i]}
        _logDebug compile file: "'$makeFile'" ---- command: "'$command'"
        echo "$(cat $command)" >>$makeFile
        echo "" >>$makeFile
    done

    _logDebug compile file: "'$makeFile'" main.post
    echo "####################" >>$makeFile
    echo "# run" >>$makeFile
    echo "" >>$makeFile
    echo "main \$*" >>$makeFile

    end=$(date +%s)
    duration=$((end - start))
    _logInfo compiled. \(${duration}s\)
}

_compileComposeEnv() {
    _logInfo compile... compose env
    start=$(date +%s)

    _logDebug compile file: "'$composeEnv'" create
    touch $composeEnv

    _logDebug compile file: "'$composeEnv'" vars
    envs=($(find "$tmpResources/" -name 'docker-compose.*.env' -exec echo "{}" \;))
    n=${#envs[@]}
    if [ "$n" -gt "0" ]; then
        for ((i = 0; i < ${n}; i++)); do
            e=${envs[$i]}
            _logDebug compile file: "'$composeEnv'" var: "'$e'"
            echo "$(cat $e)" >>$composeEnv
        done
    fi

    end=$(date +%s)
    duration=$((end - start))
    _logInfo compiled. \(${duration}s\)
}

_compileComposeFile() {
    _logInfo compile... composefile
    start=$(date +%s)

    _logDebug compile file: "'$composeFile'" create
    touch $composeFile

    _logDebug compile file: "'$composeFile'" version
    echo "####################" >$composeFile
    echo "version: \"3\"" >>$composeFile

    _logDebug compile file: "'$composeFile'" services
    services=($(find "$tmpResources/" -name 'docker-compose.*-service.yml' -exec echo "{}" \;))
    n=${#services[@]}
    if [ "$n" -gt "0" ]; then
        echo "" >>$composeFile
        echo "####################" >>$composeFile
        echo "services:" >>$composeFile
        for ((i = 0; i < ${n}; i++)); do
            service=${services[$i]}
            _logDebug compile file: "'$composeFile'" -- service: "'$service'"
            echo "$(cat $service)" >>$composeFile
        done
    fi

    _logDebug compile file: "'$composeFile'" volumes
    volumes=($(find "$tmpResources/" -name 'docker-compose.*-volume.yml' -exec echo "{}" \;))
    n=${#volumes[@]}
    if [ "$n" -gt "0" ]; then
        echo "" >>$composeFile
        echo "####################" >>$composeFile
        echo "volumes:" >>$composeFile
        for ((i = 0; i < ${n}; i++)); do
            volume=${volumes[$i]}
            _logDebug compile file: "'$composeFile'" -- volume: "'$volume'"
            echo "$(cat $volume)" >>$composeFile
        done
    fi

    _logDebug compile file: "'$composeFile'" networks
    networks=($(find "$tmpResources/" -name 'docker-compose.*-network.yml' -exec echo "{}" \;))
    n=${#networks[@]}
    if [ "$n" -gt "0" ]; then
        echo "" >>$composeFile
        echo "####################" >>$composeFile
        echo "networks:" >>$composeFile
        for ((i = 0; i < ${n}; i++)); do
            network=${networks[$i]}
            _logDebug compile file: "'$composeFile'" -- network: "'$network'"
            echo "$(cat $network)" >>$composeFile
        done
    fi

    end=$(date +%s)
    duration=$((end - start))
    _logInfo compiled. \(${duration}s\)
}

main $*
