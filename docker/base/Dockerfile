#
# This file is part of SITS Docker.
# Copyright (C) 2022 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.

ARG BASE_IMAGE=ubuntu:20.04
FROM ${BASE_IMAGE}

#
# Dockerfile metadata
#
LABEL "org.brazildatacube.title"="SITS Docker Base Image (Base Image)"
LABEL "org.brazildatacube.maintainer"="Brazil Data Cube <brazildatacube@inpe.br>"
LABEL "org.brazildatacube.description"="Ubuntu-based base image for the SITS Docker images."

LABEL "org.brazildatacube.sits-commit-ref"="862cb6bf6b41054c3709d0bb464406f35483621a"

ARG ROOT_USER=root
USER ${ROOT_USER}

ENV TZ=Etc/UTC
ENV DEBIAN_FRONTEND=noninteractive

#
# Installing the dependencies.
#
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    gdal-bin git \
    htop \
    locales \
    lbzip2 \
    libfftw3-dev \
    libcairo2-dev \
    libgdal-dev libgeos-dev libgit2-dev libgsl0-dev \
    libgl1-mesa-dev  libglu1-mesa-dev \
    libhdf4-alt-dev libhdf5-dev \
    libjq-dev \
    libnetcdf-dev \
    libpq-dev libproj-dev libprotobuf-dev \
    libsqlite3-dev libssl-dev \
    libudunits2-dev libunwind-dev \
    netcdf-bin \
    postgis protobuf-compiler \
    rsync \
    sqlite3 \
    texlive-latex-base tk-dev \
    unixodbc-dev \
    vim \
    wget \
    qpdf \
    texlive-fonts-extra \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-fonts-recommended \
    ghostscript \
    pandoc \
    && rm -rf /var/lib/apt/lists/*

#
# Configuring the O.S locale
#
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#
# Configuring the non-root base user.
#
RUN adduser --disabled-password --gecos "" sits \
     && echo sits:sits | chpasswd
