#!/usr/bin/env bash

DOCKER_IMAGE="dockube/dockube-nfs"
DOCKER_TAG="18.04"

#### Halt script on error
set -e

echo '##### Print docker version'
docker --version

echo '##### Print environment'
env | sort

echo "FROM ${DOCKER_IMAGE}:${DOCKER_TAG}" > Dockerfile.test &&
docker build --no-cache -t "${DOCKER_IMAGE}:${DOCKER_TAG}-test" -f Dockerfile.test . &&
docker run -it -d "${DOCKER_IMAGE}:${DOCKER_TAG}-test" /bin/bash &&
docker ps -a
rm Dockerfile.test
