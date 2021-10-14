from ubuntu:20.04

# env
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

ENV PYTHON_VERSION='3.9'
ENV CONDA_VERSION='4.10.3'
ENV MAMBA_VERSION='0.17.0'

ENV CONDA_HOME=/opt/conda
ENV CONDA_BIN=/opt/conda/bin/conda
ENV MAMBA_BIN=/opt/conda/bin/mamba

ENV PATH="/opt/conda/bin:${PATH}"

# prepare
RUN apt-get -qq update && apt-get --yes -qq upgrade && \
    apt-get install --yes -qq \
    apt-utils \
    apt-transport-https\
    ca-certificates\
    curl\
    gnupg-agent\
    software-properties-common\
    unzip \
    wget

# install conda
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b -s -p ${CONDA_HOME}

# https://bioconda.github.io/user/install.html#set-up-channels
# https://conda-forge.org/docs/user/tipsandtricks.html#how-to-fix-it
RUN ${CONDA_BIN} config --add channels defaults && \
    ${CONDA_BIN} config --add channels bioconda && \
    ${CONDA_BIN} config --add channels conda-forge && \
    ${CONDA_BIN} config --set channel_priority strict

# https://conda.io/projects/conda/en/latest/user-guide/configuration/use-condarc.html#always-yes
# RUN ${CONDA_BIN} config --set always_yes true
# https://docs.conda.io/projects/conda/en/latest/configuration.html
# RUN ${CONDA_BIN} config --set always_copy true
# RUN ${CONDA_BIN} config --set channel_priority disabled
# RUN ${CONDA_BIN} config --set verbosity 1
# RUN ${CONDA_BIN} config --set quiet true

# install : warning python may update conda
RUN ${CONDA_BIN} install --yes python=${PYTHON_VERSION} conda=${CONDA_VERSION} mamba=${MAMBA_VERSION} conda-build

# clean
RUN apt-get --yes -qq autoremove && apt-get --yes -qq autoclean

# test
# RUN ${CONDA_BIN} config --show

RUN ${CONDA_BIN} --version && ${MAMBA_BIN} --version
