#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in Travis CI
# DOCKER_USERNAME
# DOCKER_PASSWORD

set -e

image="alpine/git"

tag=`make next-version`

docker build --no-cache -t ${image}:${tag} .
docker tag ${image}:${tag} ${image}:latest

if [[ "$TRAVIS_BRANCH" == "master" ]]; then
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  docker push ${image}:${tag}
  docker push ${image}:latest
fi

make release
