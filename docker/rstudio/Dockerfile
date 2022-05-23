#
# This file is part of SITS Docker.
# Copyright (C) 2022 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.

ARG BASE_IMAGE=brazildatacube/sits:0.17.0
FROM ${BASE_IMAGE}

#
# Dockerfile metadata
#
LABEL "org.brazildatacube.title"="SITS Docker R Image (RStudio image)"
LABEL "org.brazildatacube.maintainer"="Brazil Data Cube <brazildatacube@inpe.br>"
LABEL "org.brazildatacube.description"="SITS-enabled RStudio Docker Image."

#
# Preparing the entrypoint script.
#
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

#
# Installing the RStudio and its dependencies.
#
WORKDIR /root
RUN apt-get update -y \
    && apt-get install -y \
        gdebi-core \
        tini \
        psmisc \
        sudo \
        libclang-dev \
    && rm -rf /var/lib/apt/lists/*

ARG RSTUDIO_VERSION=rstudio-server-2022.02.2-485-amd64
RUN wget https://download2.rstudio.org/server/bionic/amd64/${RSTUDIO_VERSION}.deb --no-check-certificate \
    && gdebi ${RSTUDIO_VERSION}.deb -n \
    && rm ${RSTUDIO_VERSION}.deb

#
# Configure Tini entrypoint
#
ENTRYPOINT ["tini", "--"]
CMD ["/usr/local/bin/entrypoint.sh"]
