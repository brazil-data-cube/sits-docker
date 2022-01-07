#!/bin/bash
# Script adapted from: https://github.com/rocker-org/rocker-versioned2/blob/071c6a3e3eabe0eb36706fc6f50df477ca41abc7/scripts/install_python.sh
set -e

## NOTE: this runs as user NB_USER!
PYTHON_VENV_PATH=${PYTHON_VENV_PATH:-/opt/venv/reticulate}
DEFAULT_USER=${DEFAULT_USER:-rstudio}
NB_USER=${NB_USER:-${DEFAULT_USER}}
NB_UID=${NB_UID:-1000}
WORKDIR=${WORKDIR:-/home/${NB_USER}}
usermod -l ${NB_USER} ${DEFAULT_USER}

# And set ENV for R! It doesn't read from the environment...
echo "PATH=${PATH}" >> ${R_HOME}/etc/Renviron.site
echo "export PATH=${PATH}" >> ${WORKDIR}/.profile

## This gets run as user
su ${NB_USER}
pip3 install --no-cache-dir jupyter-rsession-proxy>=2.0 notebook jupyterlab

R --quiet -e "remotes::install_github('IRkernel/IRkernel')"
R --quiet -e "IRkernel::installspec(user=FALSE)"
