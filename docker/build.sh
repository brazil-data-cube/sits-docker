#!/bin/bash
#
# This file is part of SITS Docker.
# Copyright (C) 2021 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

set -eoux pipefail

#
# General variables
#
SITS_BUILD_MODE=""
SITS_R_VERSION="4.0.3"
SITS_TAG_PREFIX="bdc"
SITS_UBUNTU_VERSION="20.04"


#
# General functions
#
usage() {
    echo "Usage: $0 [-n] [-u <18.04|20.04>] [-r <4.0.1|4.0.2|4.0.3>] [-t <0.9.8>] [-p <bdc|registry.dpi.inpe.br>]" 1>&2;

    exit 1;
}


#
# Get build options
#
while getopts "nu:r:t:p:" o; do
    case "${o}" in
        n)
            SITS_BUILD_MODE="--no-cache"
            ;;
        p)
            SITS_TAG_SUFFIX=${OPTARG}
            ;;
        r)
            SITS_R_VERSION=${OPTARG}
            ;;
        t)
            SITS_TAG_VERSION=${OPTARG}
            ;;
        u)
            SITS_UBUNTU_VERSION=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${SITS_TAG_SUFFIX}" ]; then
    usage
fi


#
# Build a Linux Ubuntu image with all the dependencies already installed
#
echo "Building base Linux Ubuntu image for SITS..."

cd ubuntu

SITS_BASE_UBUNTU_IMAGE="ubuntu:${SITS_UBUNTU_VERSION}"
SITS_UBUNTU_IMAGE_TAG="${SITS_TAG_PREFIX}/sits-ubuntu:${SITS_UBUNTU_VERSION}"

docker build ${SITS_BUILD_MODE} \
       --build-arg BASE_IMAGE=${SITS_BASE_UBUNTU_IMAGE} \
       -t ${SITS_UBUNTU_IMAGE_TAG} \
       --file Dockerfile .

#
# Build R image with all the package dependencies already installed
#
echo "Building base R image for SITS..."

cd ../R

SITS_R_DOCKER_IMAGE_TAG="${SITS_TAG_PREFIX}/sits-ubuntu-${SITS_UBUNTU_VERSION}-r:${SITS_R_VERSION}"

docker build ${SITS_BUILD_MODE} \
       --build-arg BASE_IMAGE=${SITS_UBUNTU_IMAGE_TAG} \
       -t ${SITS_R_DOCKER_IMAGE_TAG} \
       --file Dockerfile  .


#
# Build final SITS image
#
echo "Building SITS image..."

cd ../sits

SITS_DOCKER_IMAGE_TAG="${SITS_TAG_PREFIX}/sits-ubuntu-${SITS_UBUNTU_VERSION}-r-${SITS_R_VERSION}:${SITS_TAG_VERSION}"

docker build ${SITS_BUILD_MODE} \
       --build-arg BASE_IMAGE=${SITS_R_DOCKER_IMAGE_TAG} \
       -t ${SITS_DOCKER_IMAGE_TAG} \
       --file Dockerfile  .

#
# Build RStudio for SITS image
#
echo "Building RStudio for SITS image..."

cd ../RStudio

SITS_RSTUDIO_DOCKER_IMAGE_TAG="${SITS_TAG_PREFIX}/sits-ubuntu-${SITS_UBUNTU_VERSION}-r-${SITS_R_VERSION}-rstudio:${SITS_TAG_VERSION}"

docker build ${SITS_BUILD_MODE} \
       --build-arg BASE_IMAGE=${SITS_DOCKER_IMAGE_TAG} \
       -t ${SITS_RSTUDIO_DOCKER_IMAGE_TAG} \
       --file Dockerfile  .

#if [ ! -f "${UBUNTU_DOCKER_FILE_NAME}" ]
#then
#    echo "No file named ${UBUNTU_DOCKER_FILE_NAME} found!"
#    exit 1
#fi