#!/bin/bash
#
# This file is part of SITS Docker.
# Copyright (C) 2021 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

set -eou pipefail
cd docker

#
# General variables
#
SITS_BUILD_MODE=""
SITS_TAG_VERSION="0.15.0-3"
SITS_TAG_PREFIX="brazildatacube"

SITSDATA_COMMIT_REF="16c8fa721a378bef448a6efae826e6512e38b6f8"

SITS_R_VERSION="4"
SITS_ENVIRONMENT_TYPE="full"

SITS_UBUNTU_VERSION="20.04"

#
# General functions
#
usage() {
    echo "Usage: $0 [-n] [-t <0.9.8>] [-p <brazoldatacube|registry.dpi.inpe.br>] [-e <full|minimal>]" 1>&2;

    exit 1;
}

#
# Get build options
#
while getopts "n:t:p:h:e" o; do
    case "${o}" in
        e)
            SITS_ENVIRONMENT_TYPE=${OPTARG}
            ;;
        n)
            SITS_BUILD_MODE="--no-cache"
            ;;
        p)
            SITS_TAG_SUFFIX=${OPTARG}
            ;;
        t)
            SITS_TAG_VERSION=${OPTARG}
            ;;
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done

#
# Build a image with all the dependencies already installed
#
echo "Building base image for SITS..."
cd base

SITS_BASE_IMAGE="ubuntu:${SITS_UBUNTU_VERSION}"
SITS_BASE_IMAGE_TAG="${SITS_TAG_PREFIX}/sits-base:${SITS_UBUNTU_VERSION}"

docker build ${SITS_BUILD_MODE} \
       --build-arg BASE_IMAGE=${SITS_BASE_IMAGE} \
       -t ${SITS_BASE_IMAGE_TAG} \
       --file Dockerfile .

#
# Build R image with all the package dependencies already installed
#
echo "Building base R image for SITS..."
cd ../r

SITS_R_DOCKER_IMAGE_TAG="${SITS_TAG_PREFIX}/sits-r:${SITS_R_VERSION}"
docker build ${SITS_BUILD_MODE} \
       --build-arg BASE_IMAGE=${SITS_BASE_IMAGE_TAG} \
       --build-arg SITS_TAG_VERSION=v${SITS_TAG_VERSION} \
       --build-arg SITS_ENVIRONMENT_TYPE=${SITS_ENVIRONMENT_TYPE} \
       -t ${SITS_R_DOCKER_IMAGE_TAG} \
       --file Dockerfile  .

#
# Build final SITS image
#
echo "Building SITS image..."
cd ../sits

SITS_DOCKER_IMAGE_TAG="${SITS_TAG_PREFIX}/sits:${SITS_TAG_VERSION}"
docker build ${SITS_BUILD_MODE} \
       --build-arg BASE_IMAGE=${SITS_R_DOCKER_IMAGE_TAG} \
       --build-arg SITS_TAG_VERSION=v${SITS_TAG_VERSION} \
       --build-arg SITSDATA_COMMIT_REF=${SITSDATA_COMMIT_REF} \
       -t ${SITS_DOCKER_IMAGE_TAG} \
       --file Dockerfile  .

#
# Build RStudio for SITS image
#
echo "Building RStudio for SITS image..."
cd ../rstudio

SITS_RSTUDIO_DOCKER_IMAGE_TAG="${SITS_TAG_PREFIX}/sits-rstudio:${SITS_TAG_VERSION}"
docker build ${SITS_BUILD_MODE} \
       --build-arg BASE_IMAGE=${SITS_DOCKER_IMAGE_TAG} \
       -t ${SITS_RSTUDIO_DOCKER_IMAGE_TAG} \
       --file Dockerfile  .

#
# Build Jupyter for SITS image
#
echo "Building Jupyter for SITS image..."
cd ../jupyter

SITS_JUPYTER_DOCKER_IMAGE_TAG="${SITS_TAG_PREFIX}/sits-jupyter:${SITS_TAG_VERSION}"
docker build ${SITS_BUILD_MODE} \
       --build-arg BASE_IMAGE=${SITS_RSTUDIO_DOCKER_IMAGE_TAG} \
       -t ${SITS_JUPYTER_DOCKER_IMAGE_TAG} \
       --file Dockerfile  .
