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
ARG BASE_IMAGE=brazildatacube/sits-rstudio:1.1.0
FROM ${BASE_IMAGE}

#
# Dockerfile metadata
#
LABEL "org.brazildatacube.title"="SITS Docker R Image (JupyterLab image)"
LABEL "org.brazildatacube.maintainer"="Brazil Data Cube <brazildatacube@inpe.br>"
LABEL "org.brazildatacube.description"="SITS-enabled JupyterLab with RStudio Docker Image."

USER ${BASE_USER}

WORKDIR /tmp
RUN mamba install --quiet --yes \
    'jupyter-rsession-proxy>=2.0' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${BASE_USER}" && \
    chmod -R u+rwx "/home/${BASE_USER}/work"


ARG SITS_NOTEBOOKS_REPO
ARG SITS_TAG_VERSION

WORKDIR /home/${BASE_USER}

RUN git clone -c advice.detachedHead=false -b ${SITS_TAG_VERSION} https://github.com/${SITS_NOTEBOOKS_REPO} --single-branch

#
# Defining the entrypoint CMD.
#
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]