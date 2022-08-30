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

# install crane
curl -L https://github.com/tsuru/crane/releases/download/1.0.0/crane-1.0.0-linux_amd64.tar.gz -o crane-1.0.0-linux_amd64.tar.gz
tar zxvf crane-1.0.0-linux_amd64.tar.gz
chmod +x crane

if [[ "$TRAVIS_BRANCH" == "master" && "$TRAVIS_PULL_REQUEST" == false ]]; then
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  docker buildx create --use
  ${DOCKER_PUSH} -t ${image}:v${VERSION} .
  crane copy ${image}:v${VERSION} ${image}:latest
  crane copy ${image}:v${VERSION} ${image}:${VERSION}

fi

if [[ "$TRAVIS_BRANCH" == "feature/non-root" && "$TRAVIS_PULL_REQUEST" == false ]]; then
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  ${DOCKER_PUSH} -t ${image}:user .
  crane copy ${image}:user ${image}:v${VERSION}-user
  crane copy ${image}:user ${image}:${VERSION}-user
fi
