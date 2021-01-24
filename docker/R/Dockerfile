ARG BASE_IMAGE=bdc/sits-ubuntu:20.04
FROM ${BASE_IMAGE}

ENV TZ=Etc/UTC
ENV DEBIAN_FRONTEND=noninteractive

RUN apt install gnupg2 software-properties-common -y \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
    && apt update -y \
    && apt-get install -y --no-install-recommends \
        r-base \
        r-base-dev \
        r-recommended \
        littler

# add littler in path
# based on: https://github.com/rocker-org/rocker/commit/9a8c555427dd572d3778d3af31e3e55a37c8fb70
RUN ln -s /usr/share/doc/littler/examples/install.r /usr/local/bin/install.r \
    && ln -s /usr/share/doc/littler/examples/install2.r /usr/local/bin/install2.r \
    && install.r docopt

# install geospatial dependencies
# based on: https://github.com/rocker-org/geospatial
RUN install2.r --error \
    classInt \
    deldir \
    geoR geosphere gstat \
    hdf5r \
    mapdata maptools \
    ncdf4 \
    proj4 \
    RColorBrewer RNetCDF \
    raster rgdal rgeos rlas \
    sf sp spacetime spatstat spdep

# install user extra packages
COPY extras.R .

ARG SITS_TAG_VERSION
ARG SITS_ENVIRONMENT_TYPE=full
RUN wget https://raw.githubusercontent.com/e-sensing/sits/${SITS_TAG_VERSION}/DESCRIPTION \
    && Rscript extras.R \
    && rm extras.R DESCRIPTION

ARG BASE_USER=root
USER ${BASE_USER}

RUN echo "reticulate::install_miniconda()" | R --no-save

RUN echo "keras::install_keras()" | R --no-save

USER ${ROOT_USER}

