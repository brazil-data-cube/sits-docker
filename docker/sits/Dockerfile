#
# This file is part of SITS Docker.
# Copyright (C) 2022 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.

ARG BASE_IMAGE=brazildatacube/sits-r:1.1.0
FROM ${BASE_IMAGE}

#
# Dockerfile metadata
#
LABEL "org.brazildatacube.title"="SITS Docker R Image (SITS-enabled image)"
LABEL "org.brazildatacube.maintainer"="Brazil Data Cube <brazildatacube@inpe.br>"
LABEL "org.brazildatacube.description"="SITS-enabled Docker Image."

USER ${ROOT_USER}

#
# Installing the SITS and SITS Data Packages.
#
COPY install.R .

ARG SITS_TAG_VERSION
ARG SITSDATA_COMMIT_REF

RUN Rscript install.R \
    && rm install.R

USER ${BASE_USER}