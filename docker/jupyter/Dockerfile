#
# This file is part of SITS Docker.
# Copyright (C) 2022 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.

ARG BASE_IMAGE=brazildatacube/sits:0.15.0-1
FROM ${BASE_IMAGE}

#
# Dockerfile metadata
#
LABEL "org.brazildatacube.title"="SITS Docker R Image (JupyterLab image)"
LABEL "org.brazildatacube.maintainer"="Brazil Data Cube <brazildatacube@inpe.br>"
LABEL "org.brazildatacube.description"="SITS-enabled JupyterLab with RStudio Docker Image."

LABEL "org.brazildatacube.sits-commit-ref"="862cb6bf6b41054c3709d0bb464406f35483621a"

ENV NB_USER=sits
ENV DEFAULT_USER=sits

#
# Configuring the Python and Jupyter environments.
#
COPY install_python.sh install_python.sh
COPY install_jupyter.sh install_jupyter.sh

RUN ./install_python.sh
RUN ./install_jupyter.sh

#
# Defining the entrypoint CMD.
#
CMD jupyter lab --ip 0.0.0.0

USER ${NB_USER}

WORKDIR /home/${NB_USER}
