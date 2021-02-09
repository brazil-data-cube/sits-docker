ARG BASE_IMAGE=ubuntu:20.04
FROM ${BASE_IMAGE}

ARG ROOT_USER=root
USER ${ROOT_USER}

ENV TZ=Etc/UTC
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
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
    ghostscript \
    pandoc

# Configure locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
