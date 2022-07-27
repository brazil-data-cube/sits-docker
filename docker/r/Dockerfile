#
# This file is part of SITS Docker.
# Copyright (C) 2022 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.

ARG BASE_IMAGE=brazildatacube/sits-base:1.1.0
FROM ${BASE_IMAGE}

#
# Dockerfile metadata
#
LABEL "org.brazildatacube.title"="SITS Docker R Image (R image)"
LABEL "org.brazildatacube.maintainer"="Brazil Data Cube <brazildatacube@inpe.br>"
LABEL "org.brazildatacube.description"="Ubuntu-based R image for the SITS Docker images."

USER ${ROOT_USER}

#
# Installing the base packages
#
RUN apt update -y \
    && apt install -y \
        gnupg2 \
        software-properties-common \
	    gpg \
        gpg-agent \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 \
    && add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
    && apt update -y \
    && apt-get install -y --no-install-recommends \
        r-base \
        r-base-dev \
        r-recommended \
        littler \
    && rm -rf /var/lib/apt/lists/*

#
# Configuring the littler in path
#  > based on: https://github.com/rocker-org/rocker/commit/9a8c555427dd572d3778d3af31e3e55a37c8fb70
#
RUN ln -s /usr/share/doc/littler/examples/install.r /usr/local/bin/install.r \
    && ln -s /usr/share/doc/littler/examples/install2.r /usr/local/bin/install2.r \
    && install.r docopt

#
# Installing GeoSpatial dependencies
#  > based on: https://github.com/rocker-org/geospatial
#
RUN install2.r --error \
    classInt \
    deldir \
    geosphere gstat \
    hdf5r \
    mapdata maptools \
    ncdf4 \
    proj4 \
    RColorBrewer RNetCDF \
    raster rgdal rgeos rlas \
    sf sp spacetime spatstat spdep \
    rmarkdown \
    Rcpp \
    knitr \
    testthat \
    remotes \
    qpdf \
    shiny \
    pacman \
    covr \
    withr \
    devtools

#
# Installing SITS dependencies packages
#
COPY install.R .

ARG SITS_TAG_VERSION
ARG SITS_ENVIRONMENT_TYPE
RUN wget https://raw.githubusercontent.com/e-sensing/sits/${SITS_TAG_VERSION}/DESCRIPTION \
    && Rscript install.R \
    && rm install.R DESCRIPTION

#
# Installing lantern dependencies
#
RUN echo "torch::install_torch()" | R --no-save

#
# Copy local file
#
COPY install_irkernel.sh create_user_dir.R /usr/local/bin/

#
# Install IRkernel for R kernel in jupyter notebooks and creating the 
# user's package directory
#
RUN chmod -R a+rx /usr/local/bin/ \ 
    && /usr/local/bin/install_irkernel.sh \ 
    && fix-permissions "/home/${BASE_USER}" 


USER ${BASE_USER}

#
# Create an R personal directory to the base user
#
RUN Rscript /usr/local/bin/create_user_dir.R

WORKDIR "/home/${BASE_USER}"