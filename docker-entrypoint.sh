#!/bin/sh

# A beginning user should be able to docker run image bash (or sh) without
# needing to learn about --entrypoint
# https://github.com/docker-library/official-images#consistency

set -e

# allow to run "sh" or "bash"
if [ "$1" = 'sh' ] || [ "$1" = 'bash' ]; then
    exec "$@"
else
  # else default to run command with git
  exec git "$@"
fi
