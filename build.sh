#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in Travis CI
# DOCKER_USERNAME
# DOCKER_PASSWORD

set -e

image="alpine/git"

docker build --no-cache -t ${image}:latest .

DOCKER_PUSH="docker buildx build --no-cache --push --platform linux/amd64,linux/arm/v7,linux/arm64/v8,linux/arm/v6,linux/ppc64le,linux/s390x,linux/riscv64"

# add another tag with git version, with this way, we can check this git image health
VERSION=($(docker run -i --rm ${image}:latest version|awk '{print $NF}'))
echo ${VERSION}

# install crane
curl -LO https://github.com/google/go-containerregistry/releases/download/v0.11.0/go-containerregistry_Linux_x86_64.tar.gz
tar zxvf go-containerregistry_Linux_x86_64.tar.gz
chmod +x crane

if [[ "$TRAVIS_BRANCH" == "master" && "$TRAVIS_PULL_REQUEST" == false ]]; then
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  docker buildx create --use
  ${DOCKER_PUSH} -t ${image}:latest .
  ./crane copy ${image}:latest ${image}:v${VERSION}
  ./crane copy ${image}:latest ${image}:${VERSION}
fi

if [[ "$TRAVIS_BRANCH" == "feature/edge" && "$TRAVIS_PULL_REQUEST" == false ]]; then
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  docker buildx create --use
  ${DOCKER_PUSH} -t ${image}:edge .
  ./crane copy ${image}:edge ${image}:edge-${VERSION}
fi
