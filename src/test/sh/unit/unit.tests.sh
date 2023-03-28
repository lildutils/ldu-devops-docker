#!/bin/bash

main() {
    testEchoCommaSeparatedVariable
}

testEchoCommaSeparatedVariable() {
    UFW_ALLOW_IN=http,https,ssh
    for rule in ${UFW_ALLOW_IN//,/ }; do
        echo "$rule"
    done

    UFW_ALLOW_OUT=http,https,53/udp
    for rule in ${UFW_ALLOW_OUT//,/ }; do
        echo "$rule"
    done
}

main
