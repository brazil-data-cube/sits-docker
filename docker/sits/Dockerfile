ARG BASE_IMAGE=bdc/sits-ubuntu-20.04-r:4.0.3
FROM ${BASE_IMAGE}

COPY install_sits.R .

RUN Rscript install_sits.R && rm install_sits.R
