ARG BASE_IMAGE=brazildatacube/sits:0.15.0-1
FROM ${BASE_IMAGE}

ENV NB_USER=sits
ENV DEFAULT_USER=sits

COPY install_python.sh install_python.sh
COPY install_jupyter.sh install_jupyter.sh

RUN ./install_python.sh
RUN ./install_jupyter.sh

CMD jupyter lab --ip 0.0.0.0

USER ${NB_USER}

WORKDIR /home/${NB_USER}
