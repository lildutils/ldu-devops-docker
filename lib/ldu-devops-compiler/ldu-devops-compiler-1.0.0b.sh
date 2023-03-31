#!/bin/bash

main() {
    bin=$(realpath $(dirname "${BASH_SOURCE[0]}")/bin/)
    logger=$(realpath $(dirname "${BASH_SOURCE[0]}")/bin/logger.sh)
    res=$(realpath $(dirname "${BASH_SOURCE[0]}")/resources/)

    rootPath=$(realpath $(dirname "${BASH_SOURCE[0]}")/$1)
    makefile=$rootPath/make.sh
    composefile=$rootPath/resources/docker-compose.yml

    _compileMakefile
    _compileComposefile
}

_logDebug() {
    /bin/sh $logger logDebug $*
}

_logInfo() {
    /bin/sh $logger logInfo $*
}

_compileMakefile() {
    _logInfo compile... makefile
    start=$(date +%s)

    _logDebug compile file: "'$makefile'" create
    touch $makefile

    _logDebug compile file: "'$makefile'" main.pre
    echo "####################" >$makefile
    echo "#!/bin/bash" >>$makefile
    echo "" >>$makefile

    _logDebug compile file: "'$makefile'" main
    echo "####################" >>$makefile
    echo "# main" >>$makefile
    echo "" >>$makefile
    echo "$(cat $bin/main.sh)" >>$makefile
    echo "" >>$makefile

    _logDebug compile file: "'$makefile'" -- tasks
    echo "####################" >>$makefile
    echo "# tasks" >>$makefile
    echo "" >>$makefile
    tasks=($(find "$bin/" -name 'task*.sh' -exec echo "{}" \;))
    n=${#tasks[@]}
    for ((i = 0; i < ${n}; i++)); do
        task=${tasks[$i]}
        _logDebug compile file: "'$makefile'" ---- task: "'$task'"
        echo "$(cat $task)" >>$makefile
        echo "" >>$makefile
    done

    _logDebug compile file: "'$makefile'" -- commands
    echo "####################" >>$makefile
    echo "# commands" >>$makefile
    echo "" >>$makefile
    commands=($(find "$bin/" -name 'do*.sh' -exec echo "{}" \;))
    n=${#commands[@]}
    for ((i = 0; i < ${n}; i++)); do
        command=${commands[$i]}
        _logDebug compile file: "'$makefile'" ---- command: "'$command'"
        echo "$(cat $command)" >>$makefile
        echo "" >>$makefile
    done

    _logDebug compile file: "'$makefile'" main.post
    echo "####################" >>$makefile
    echo "main \$*" >>$makefile

    end=$(date +%s)
    duration=$((end - start))
    _logInfo compiled. \(${duration}s\)
}

_compileComposefile() {
    _logInfo compile... composefile
    start=$(date +%s)

    _logDebug compile file: "'$composefile'" create
    touch $composefile

    _logDebug compile file: "'$composefile'" version
    echo "####################" >$composefile
    echo "version: \"3\"" >>$composefile

    _logDebug compile file: "'$composefile'" services
    services=($(find "$res/" -name 'docker-compose.*-service.yml' -exec echo "{}" \;))
    n=${#services[@]}
    if [ "$n" -gt "0" ]; then
        echo "" >>$composefile
        echo "####################" >>$composefile
        echo "services:" >>$composefile
        for ((i = 0; i < ${n}; i++)); do
            service=${services[$i]}
            _logDebug compile file: "'$composefile'" -- service: "'$service'"
            echo "$(cat $service)" >>$composefile
        done
    fi

    _logDebug compile file: "'$composefile'" volumes
    volumes=($(find "$res/" -name 'docker-compose.*-volume.yml' -exec echo "{}" \;))
    n=${#volumes[@]}
    if [ "$n" -gt "0" ]; then
        echo "" >>$composefile
        echo "####################" >>$composefile
        echo "volumes:" >>$composefile
        for ((i = 0; i < ${n}; i++)); do
            volume=${volumes[$i]}
            _logDebug compile file: "'$composefile'" -- volume: "'$volume'"
            echo "$(cat $volume)" >>$composefile
        done
    fi

    _logDebug compile file: "'$composefile'" networks
    networks=($(find "$res/" -name 'docker-compose.*-network.yml' -exec echo "{}" \;))
    n=${#networks[@]}
    if [ "$n" -gt "0" ]; then
        echo "" >>$composefile
        echo "####################" >>$composefile
        echo "networks:" >>$composefile
        for ((i = 0; i < ${n}; i++)); do
            network=${networks[$i]}
            _logDebug compile file: "'$composefile'" -- network: "'$network'"
            echo "$(cat $network)" >>$composefile
        done
    fi

    end=$(date +%s)
    duration=$((end - start))
    _logInfo compiled. \(${duration}s\)
}

main $*
