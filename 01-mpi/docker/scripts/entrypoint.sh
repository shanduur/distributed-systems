#!/usr/bin/env bash

set -e
source /etc/utils.sh

if [ -n "${DEBUG}" ]; then
    echo_warn "> debugging enabled"
fi

if [ -n "${FOLLOWER}" ]; then
    echo_info "> this is a follower"
else
    echo_info "> this is the leader"
fi

function run {
    echo_info "> running '$@'"
    if ! $@; then
        echo_erro "> failed to run '$@'"
        if [ -n "${DEBUG}" ]; then
            echo_warn "> debugging enabled, dropping into shell"
            exec /bin/bash
        fi
        exit 1
    fi
}

# start sshd
run sudo systemctl start sshd

# start nfs server, if this is the leader
if [ -z "${FOLLOWER}" ]; then
    run sudo systemctl start rpcbind
    run sudo systemctl start nfs-kernel-server
    echo "/shared *(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports
    run sudo exportfs -a
fi

# if this is a follower, mount the leader's /shared directory
if [ -n "${FOLLOWER}" ]; then
    run sudo mount -t nfs -o nolock "docker-leader-1:/shared" "/shared"
fi

# start the provided command
if [ -z "$1" ]; then
    run exec /bin/bash
else
    run exec "$@"
fi
