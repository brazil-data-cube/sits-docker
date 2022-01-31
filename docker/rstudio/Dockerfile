ARG BASE_IMAGE=brazildatacube/sits:0.15.0-1
FROM ${BASE_IMAGE}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /root
RUN apt-get update -y \
    && apt-get install -y \
        gdebi-core \
        tini \
        psmisc \
        sudo \
        libclang-dev \
    && rm -rf /var/lib/apt/lists/*

ARG RSTUDIO_VERSION=rstudio-server-2021.09.1-372-amd64
RUN wget https://download2.rstudio.org/server/bionic/amd64/${RSTUDIO_VERSION}.deb --no-check-certificate \
    && gdebi ${RSTUDIO_VERSION}.deb -n \
    && rm ${RSTUDIO_VERSION}.deb

# Configure tini entrypoint
ENTRYPOINT ["tini", "--"]
CMD ["/usr/local/bin/entrypoint.sh"]
