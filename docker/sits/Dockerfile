ARG BASE_IMAGE=brazildatacube/sits-r:4
FROM ${BASE_IMAGE}

COPY install.R .

ARG SITS_TAG_VERSION
ARG SITSDATA_COMMIT_REF

RUN Rscript install.R \
    && rm install.R
