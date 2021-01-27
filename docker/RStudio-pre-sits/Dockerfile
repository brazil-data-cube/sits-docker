ARG BASE_IMAGE=brazildatacube/sits-base:ubuntu:20.04
FROM ${BASE_IMAGE}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# install R 4
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

WORKDIR /root
RUN apt-get update \
    && apt-get install -y \
    gdebi-core \
    tini \
    python3-gdal

ARG RSTUDIO_VERSION=rstudio-server-1.4.1103-amd64
RUN wget https://download2.rstudio.org/server/bionic/amd64/${RSTUDIO_VERSION}.deb --no-check-certificate \
    && gdebi ${RSTUDIO_VERSION}.deb -n \
    && rm ${RSTUDIO_VERSION}.deb

RUN adduser --disabled-password --gecos "" sits \
     && echo sits:sits | chpasswd

# Configure tini entrypoint
ENTRYPOINT ["tini", "--"]
CMD ["/usr/local/bin/entrypoint.sh"]
