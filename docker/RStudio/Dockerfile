ARG BASE_IMAGE=bdc/sits-ubuntu-20.04-r-4.0.3:0.9.8
FROM ${BASE_IMAGE}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /root
RUN apt-get update \
    && apt-get install -y \
    gdebi-core \
    tini

ARG RSTUDIO_VERSION=rstudio-server-1.4.1103-amd64
RUN wget https://download2.rstudio.org/server/bionic/amd64/${RSTUDIO_VERSION}.deb --no-check-certificate \
    && gdebi ${RSTUDIO_VERSION}.deb -n \
    && rm ${RSTUDIO_VERSION}.deb

RUN adduser --disabled-password --gecos "" sits \
     && echo sits:sits | chpasswd

# Configure tini entrypoint
ENTRYPOINT ["tini", "--"]
CMD ["/usr/local/bin/entrypoint.sh"]
