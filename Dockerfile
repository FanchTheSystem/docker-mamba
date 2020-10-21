from ubuntu:18.04

# env
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

ENV PYTHON_VERSION='3.6'
ENV CONDA_VERSION='4.8.5'
ENV MAMBA_VERSION='0.5.3'

ENV CONDA_HOME=/opt/conda
ENV CONDA_BIN=/opt/conda/bin/conda
ENV MAMBA_BIN=/opt/conda/bin/mamba

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

# config
RUN ${CONDA_BIN} config --add channels conda-forge
RUN ${CONDA_BIN} config --add channels bioconda
# https://conda.io/projects/conda/en/latest/user-guide/configuration/use-condarc.html#always-yes
# RUN ${CONDA_BIN} config --set always_yes true
# https://docs.conda.io/projects/conda/en/latest/configuration.html
#RUN ${CONDA_BIN} config --set always_copy true
#RUN ${CONDA_BIN} config --set channel_priority disabled
#RUN ${CONDA_BIN} config --set verbosity 1
RUN ${CONDA_BIN} config --set quiet true

# install : warning python may update conda
RUN ${CONDA_BIN} install python=${PYTHON_VERSION} --yes
RUN ${CONDA_BIN} install conda=${CONDA_VERSION} --yes
RUN ${CONDA_BIN} install mamba=${MAMBA_VERSION} --yes

# clean
RUN apt-get --yes autoremove
RUN apt-get --yes autoclean

# test
# RUN ${CONDA_BIN} config --show

RUN ${CONDA_BIN} --version
RUN ${MAMBA_BIN} --version
