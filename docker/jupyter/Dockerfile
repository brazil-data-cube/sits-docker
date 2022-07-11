#
# This file is part of SITS Docker.
# Copyright (C) 2022 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
# 
# This Dockerfile is strongly based on the Dockerfile from Jupyter Stacks, 
# see more: github.com/jupyter/docker-stacks
#
ARG BASE_IMAGE=brazildatacube/sits-rstudio:0.17.0
FROM ${BASE_IMAGE}

#
# Dockerfile metadata
#
LABEL "org.brazildatacube.title"="SITS Docker R Image (JupyterLab image)"
LABEL "org.brazildatacube.maintainer"="Brazil Data Cube <brazildatacube@inpe.br>"
LABEL "org.brazildatacube.description"="SITS-enabled JupyterLab with RStudio Docker Image."

USER root

#
# Copy local files
#
COPY install_irkernel.sh /usr/local/bin/

#
# Install IRkernel for R kernel in jupyter notebooks
#
RUN chmod a+rx /usr/local/bin/install_irkernel.sh && \
    /usr/local/bin/install_irkernel.sh && \
    fix-permissions "/home/${NB_USER}"

USER ${NB_UID}

RUN mamba install --quiet --yes \
    'jupyter-rsession-proxy>=2.0' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

#
# Defining the entrypoint CMD.
#
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]

WORKDIR /home/${NB_USER}