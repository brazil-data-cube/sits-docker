#
# This file is part of SITS Docker.
# Copyright (C) 2022 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.

ARG BASE_IMAGE=brazildatacube/sits:1.1.0
FROM ${BASE_IMAGE}

#
# Dockerfile metadata
#
LABEL "org.brazildatacube.title"="SITS Docker R Image (RStudio image)"
LABEL "org.brazildatacube.maintainer"="Brazil Data Cube <brazildatacube@inpe.br>"
LABEL "org.brazildatacube.description"="SITS-enabled RStudio Docker Image."

USER ${ROOT_USER}

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

ARG RSTUDIO_VERSION=rstudio-server-2022.07.1-554-amd64
RUN wget https://download2.rstudio.org/server/bionic/amd64/${RSTUDIO_VERSION}.deb --no-check-certificate \
    && gdebi ${RSTUDIO_VERSION}.deb -n \
    && rm ${RSTUDIO_VERSION}.deb \ 
    && mkdir -p /var/lib/rstudio-server/monitor/log/ \
    && chown rstudio-server:rstudio-server /var/lib/rstudio-server/monitor/log/

#
# Configuring the non-root base user for rstudio server only
#
RUN adduser --disabled-password --gecos "" sits \
     && echo sits:sits | chpasswd

#
# Configure Tini entrypoint
#
ENTRYPOINT ["tini", "--"]
CMD ["/usr/local/bin/entrypoint.sh"]