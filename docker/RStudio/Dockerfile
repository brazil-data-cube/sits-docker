ARG BASE_IMAGE=bdc/sits-ubuntu-20.04-r-4.0.3:0.9.8
FROM ${BASE_IMAGE}

WORKDIR /root

RUN apt-get update \
    && apt-get install -y gdebi-core wget

RUN wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1103-amd64.deb \
    && gdebi rstudio-server-1.4.1103-amd64.deb \
    && rm rstudio-server-1.4.1103-amd64.deb

CMD ["R"]