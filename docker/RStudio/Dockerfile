ARG BASE_IMAGE=bdc/sits-ubuntu-20.04-r-4.0.3:0.9.8
FROM ${BASE_IMAGE}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /root
RUN apt-get update \
    && apt-get install -y \
    gdebi-core \
    wget \
    locales \
    tini

ARG RSTUDIO_VERSION=rstudio-server-1.4.1103-amd64
RUN wget https://download2.rstudio.org/server/bionic/amd64/${RSTUDIO_VERSION}.deb \
    && gdebi rstudio-server-1.4.1103-amd64.deb -n \
    && rm rstudio-server-1.4.1103-amd64.deb

# Configure locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Configure tini entrypoint
ENTRYPOINT ["tini", "--"]
CMD ["/usr/local/bin/entrypoint.sh"]
