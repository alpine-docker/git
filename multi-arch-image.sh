#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in Travis CI
# DOCKER_USERNAME
# DOCKER_PASSWORD

set -e

function get_arch_images(){
    image=$1; shift || fatal "usage error"
    tag=$1; shift || fatal "usage error"
    archs="amd64 s390x"
    for arch in $archs; do
        if [[ "$(docker pull ${image}:${tag}-${arch} >/dev/null 2>&1 ; echo $?)" == 0 ]]; then
        	echo "${image}:${tag}-${arch} "
	fi
    done
}

image="alpine/git"
if [[ "$TRAVIS_BRANCH" == "master" && "$TRAVIS_PULL_REQUEST" == false ]]; then
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD	
  NEXT_TAG=$(cat tag.txt)
  VERSION=$(docker run -i --rm ${image}:latest-amd64 version|awk '{print $NF}')
  #create and push multi-arch 3 images - latest, ${NEXT_TAG} and v${VERSION}
  DOCKER_CLI_EXPERIMENTAL="enabled" docker manifest create ${image}:${NEXT_TAG} $(get_arch_images ${image} ${NEXT_TAG})
  DOCKER_CLI_EXPERIMENTAL="enabled" docker manifest push --purge ${image}:${NEXT_TAG}
  DOCKER_CLI_EXPERIMENTAL="enabled" docker manifest create ${image}:latest $(get_arch_images ${image} "latest")
  DOCKER_CLI_EXPERIMENTAL="enabled" docker manifest push --purge ${image}:latest
  DOCKER_CLI_EXPERIMENTAL="enabled" docker manifest create ${image}:v${VERSION} $(get_arch_images ${image} v${VERSION})
  DOCKER_CLI_EXPERIMENTAL="enabled" docker manifest push --purge ${image}:v${VERSION}
fi

if [[ "$TRAVIS_BRANCH" == "feature/non-root" && "$TRAVIS_PULL_REQUEST" == false ]]; then
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  #create and push multi-arch 2 images - user and v${VERSION}-user
  DOCKER_CLI_EXPERIMENTAL="enabled" docker manifest create ${image}:user $(get_arch_images ${image} "user")
  DOCKER_CLI_EXPERIMENTAL="enabled" docker manifest push --purge ${image}:user
  DOCKER_CLI_EXPERIMENTAL="enabled" docker manifest create ${image}:v${VERSION}-user $(get_arch_images ${image} v${VERSION}-user)
  DOCKER_CLI_EXPERIMENTAL="enabled" docker manifest push --purge ${image}:v${VERSION}-user
fi
