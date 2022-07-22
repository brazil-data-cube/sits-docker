#!/bin/bash
WORKDIR=${WORKDIR:-/home/${NB_USER}}

# And set ENV for R! It doesn't read from the environment...
echo "PATH=${PATH}" >> ${R_HOME}/etc/Renviron.site
echo "export PATH=${PATH}" >> ${WORKDIR}/.profile

R --quiet -e "remotes::install_github('IRkernel/IRkernel')"
R --quiet -e "IRkernel::installspec(user=FALSE)"