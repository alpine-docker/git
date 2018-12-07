#!/bin/sh

# A beginning user should be able to docker run image bash (or sh) without
# needing to learn about --entrypoint
# https://github.com/docker-library/official-images#consistency

set -e

# run command if it is not starting with a "-", is not a git subcommand and is an executable in PATH
if [ "${#}" -gt "0" ] && \
   [ "${1#-}" == "${1}" ] && \
   [ ! -x "/usr/libexec/git-core/git-${1}" ] && \
   command -v "${1}" > /dev/null 2>&1 ; then
    exec "${@}"
else
    # else default to run command with git
    exec git "${@}"
fi
