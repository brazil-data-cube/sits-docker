#!/bin/bash
#
# This file is part of SITS Docker.
# Copyright (C) 2022 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.

# Script adapted from: https://github.com/rocker-org/rocker-versioned2/blob/071c6a3e3eabe0eb36706fc6f50df477ca41abc7/scripts/install_python.sh

set -e

## build ARGs
NCPUS=${NCPUS:--1}

WORKON_HOME=${WORKON_HOME:-/opt/venv}
PYTHON_VENV_PATH=${PYTHON_VENV_PATH:-${WORKON_HOME}/reticulate}
RETICULATE_MINICONDA_ENABLED=${RETICULATE_MINICONDA_ENABLED:-FALSE}

apt-get update && apt-get install -y --no-install-recommends \
	libpng-dev \
        libpython3-dev \
        python3-dev \
        python3-pip \
        python3-virtualenv \
        python3-venv \
        swig && \
    rm -rf /var/lib/apt/lists/*

python3 -m pip --no-cache-dir install --upgrade \
  pip \
  setuptools \
  virtualenv

# Some TF tools expect a "python" binary
if [ ! -e /usr/local/bin/python ]; then
  ln -s $(which python3) /usr/local/bin/python
fi

mkdir -p ${WORKON_HOME}
python3 -m venv ${PYTHON_VENV_PATH}

install2.r --error --skipinstalled -n $NCPUS reticulate

## Ensure RStudio inherits this env var
echo "" >> ${R_HOME}/etc/Renviron.site
echo "WORKON_HOME=${WORKON_HOME}" >> ${R_HOME}/etc/Renviron.site
echo "RETICULATE_MINICONDA_ENABLED=${RETICULATE_MINICONDA_ENABLED}" >> ${R_HOME}/etc/Renviron.site


## symlink these so that these are available when switching to a new venv
## -f check for file, -L for link, -e for either
if [ ! -e /usr/local/bin/python ]; then
  ln -s $(which python3) /usr/local/bin/python
fi

if [ ! -e /usr/local/bin/pip ]; then
  ln -s ${PYTHON_VENV_PATH}/bin/pip /usr/local/bin/pip
fi

if [ ! -e /usr/local/bin/virtualenv ]; then
  ln -s ${PYTHON_VENV_PATH}/bin/virtualenv /usr/local/bin/virtualenv
fi

# Clean up
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/downloaded_packages
