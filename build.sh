#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in Travis CI
# DOCKER_USERNAME
# DOCKER_PASSWORD

set -e

image="alpine/git"

docker build --no-cache -t ${image}:latest .

DOCKER_PUSH="docker buildx build --no-cache --push --platform linux/amd64,linux/arm/v7,linux/arm64/v8,linux/arm/v6,linux/ppc64le,linux/s390x" 

# add another tag with git version, with this way, we can check this git image health
VERSION=($(docker run -i --rm ${image}:latest version|awk '{print $NF}'))
echo ${VERSION}

if [[ "$TRAVIS_BRANCH" == "master" && "$TRAVIS_PULL_REQUEST" == false ]]; then
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  docker buildx create --use
  ${DOCKER_PUSH} -t ${image}:latest .
  ${DOCKER_PUSH} -t ${image}:v${VERSION} .
fi

if [[ "$TRAVIS_BRANCH" == "feature/non-root" && "$TRAVIS_PULL_REQUEST" == false ]]; then
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  ${DOCKER_PUSH} -t ${image}:user .
  ${DOCKER_PUSH} -t ${image}:v${VERSION}-user .
fi
