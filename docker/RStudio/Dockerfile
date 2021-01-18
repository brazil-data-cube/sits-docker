ARG BASE_IMAGE=bdc/sits-ubuntu-20.04-r-4.0.3:0.9.8
ARG RSTUDIO_VERSION=rstudio-server-1.4.1103-amd64

FROM ${BASE_IMAGE}

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /root
RUN apt-get update \
    && apt-get install -y \
    gdebi-core \
    wget \
    locales \
    tini

RUN wget https://download2.rstudio.org/server/bionic/amd64/${RSTUDIO_VERSION}.deb \
    && gdebi rstudio-server-1.4.1103-amd64.deb -n \
    && rm rstudio-server-1.4.1103-amd64.deb

ENTRYPOINT ["tini", "--"]
CMD ["/usr/local/bin/entrypoint.sh"]
