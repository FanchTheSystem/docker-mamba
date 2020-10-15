from ubuntu:18.04

# env
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

ENV PYTHON_VERSION='3.6'
ENV CONDA_VERSION='4.8.4'
ENV MAMBA_VERSION='0.5.1'

ENV CONDA_HOME=/opt/conda
ENV CONDA_BIN=/opt/conda/bin/conda

ENV PATH="/opt/conda/bin:${PATH}"

# prepare
RUN apt-get update && apt-get --yes upgrade
RUN apt-get install --yes \
    apt-utils \
    apt-transport-https\
    ca-certificates\
    curl\
    gnupg-agent\
    software-properties-common\
    unzip \
    wget

# install conda
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN chmod +x Miniconda3-latest-Linux-x86_64.sh
RUN ./Miniconda3-latest-Linux-x86_64.sh -b -s -p ${CONDA_HOME}
RUN ${CONDA_BIN} install conda=${CONDA_VERSION} --yes
RUN ${CONDA_BIN} install python=${PYTHON_VERSION} -c conda-forge --yes
RUN ${CONDA_BIN} install mamba=${MAMBA_VERSION} -c conda-forge --yes

# clean
RUN apt-get --yes autoremove
RUN apt-get --yes autoclean

# test
