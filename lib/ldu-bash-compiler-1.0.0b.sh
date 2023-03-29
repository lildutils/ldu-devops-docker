#!/bin/bash

main() {
    file=$(realpath $(dirname "${BASH_SOURCE[0]}")/$1)
    bin=$(realpath $(dirname "${BASH_SOURCE[0]}")/bin/)
    logger=$(realpath $(dirname "${BASH_SOURCE[0]}")/bin/logger.sh)

    touch $file

    /bin/sh $logger $(date +"%Y-%m-%d %H:%M:%S.%s") [ INFO] compile... "'$file'"
    start=$(date +%s)
    /bin/sh $logger $(date +"%Y-%m-%d %H:%M:%S.%s") [DEBUG] "'$bin/main.pre.sh'"
    echo "$(cat $bin/main.pre.sh)" >>$file
    echo "" >>$file
    echo "####################" >>$file
    echo "# main" >>$file
    echo "" >>$file
    /bin/sh $logger $(date +"%Y-%m-%d %H:%M:%S.%s") [DEBUG] "'$bin/main.sh'"
    echo "$(cat $bin/main.sh)" >>$file
    echo "" >>$file
    echo "####################" >>$file
    echo "# tasks" >>$file
    echo "" >>$file
    tasks=($(find "$bin/" -name 'task*.sh' -exec echo "{}" \;))
    n=${#tasks[@]}
    for ((i = 0; i < ${n}; i++)); do
        task=${tasks[$i]}
        /bin/sh $logger $(date +"%Y-%m-%d %H:%M:%S.%s") [DEBUG] "'$task'"
        echo "$(cat $task)" >>$file
        echo "" >>$file
    done
    sleep 1
    echo "" >>$file
    echo "####################" >>$file
    echo "# commands" >>$file
    echo "" >>$file
    commands=($(find "$bin/" -name 'do*.sh' -exec echo "{}" \;))
    n=${#commands[@]}
    for ((i = 0; i < ${n}; i++)); do
        command=${commands[$i]}
        /bin/sh $logger $(date +"%Y-%m-%d %H:%M:%S.%s") [DEBUG] "'$command'"
        echo "$(cat $command)" >>$file
        echo "" >>$file
    done
    sleep 1
    echo "" >>$file
    echo "" >>$file
    /bin/sh $logger $(date +"%Y-%m-%d %H:%M:%S.%s") [DEBUG] "'$bin/main.post.sh'"
    echo "$(cat $bin/main.post.sh)" >>$file
    end=$(date +%s)
    duration=$((end - start))
    /bin/sh $logger $(date +"%Y-%m-%d %H:%M:%S.%s") [ INFO] compiled. \(${duration}s\)
}

main $1
