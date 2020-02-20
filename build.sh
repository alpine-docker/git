#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in Travis CI
# DOCKER_USERNAME
# DOCKER_PASSWORD
# GITHUB_NAME
# GITHUB_TOKEN

set -e

image="alpine/git"

LATEST_TAG=$(git ls-remote --tags origin |awk -F \/ '{print $NF}'|grep ^1.0. |sort -Vr|head -1)
if [[ -z "${LATEST_TAG}" ]]
then
    NEXT_TAG="1.0.0"
else
    NEXT_TAG=$(docker run --rm alpine/semver:5.5.0 semver -c -i patch ${LATEST_TAG})
fi
echo ${NEXT_TAG}

if [[ "$TRAVIS_BRANCH" == "master" ]]; then
  docker build --no-cache -t ${image}:${NEXT_TAG} .
  docker tag ${image}:${NEXT_TAG} ${image}:latest
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
  docker push ${image}:${NEXT_TAG}
  docker push ${image}:latest

  # push the tag
  git remote set-url origin https://${GITHUB_NAME}:${GITHUB_TOKEN}@github.com/alpine-docker/git.git
  echo "Set github Username & Email"
  git config user.name "ci"
  git config user.email "ci"
  echo "Create & Push Tag"
  git tag ${NEXT_TAG}
  git push origin ${NEXT_TAG}
fi
