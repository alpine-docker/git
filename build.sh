#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in Travis CI
# DOCKER_USERNAME
# DOCKER_PASSWORD

set -e

image="alpine/git"

tag=`git tag -l --points-at HEAD`

if [[ "$TRAVIS_BRANCH" == "master" && "${tag}" =~ ^1.0 ]]; then
  docker build --no-cache -t ${image}:${tag} .
  docker tag ${image}:${tag} ${image}:latest
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  docker push ${image}:${tag}
  docker push ${image}:latest
fi
