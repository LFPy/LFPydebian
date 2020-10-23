# -------- base ---------
FROM debian:latest AS base

RUN apt-get update && \
    apt-get install -y \
        wget \
        bash \
        build-essential \
        make \
        gcc \
        g++ \
        git \
        libncurses-dev \
        python3 \
        python3-numpy \
        python3-scipy \
        python3-matplotlib \
        python3-h5py \
        python3-yaml \
        python3-pytest \
        python3-pip \
        cython3 \
        jupyter \
        ipython3


# ------- MPICH -----------
FROM base AS mpich

ENV MPICH_DIR=/opt/mpich-3.3
ENV SINGULARITY_MPICH_DIR=$MPICH_DIR
ENV SINGULARITYENV_APPEND_PATH=$MPICH_DIR/bin
ENV SINGULAIRTYENV_APPEND_LD_LIBRARY_PATH=$MPICH_DIR/lib

RUN apt-get update && apt-get install -y \
    gfortran

ENV MPICH_VERSION=3.3
ENV MPICH_URL="http://www.mpich.org/static/downloads/$MPICH_VERSION/mpich-$MPICH_VERSION.tar.gz"
ENV MPICH_DIR=/opt/mpich

RUN mkdir -p /tmp/mpich
RUN mkdir -p /opt
RUN cd /tmp/mpich && wget -O mpich-$MPICH_VERSION.tar.gz $MPICH_URL && tar xzf mpich-$MPICH_VERSION.tar.gz
RUN cd /tmp/mpich/mpich-$MPICH_VERSION && ./configure --prefix=$MPICH_DIR && make install

ENV PATH=$MPICH_DIR/bin:$PATH
ENV LD_LIBRARY_PATH=$MPICH_DIR/lib:$LD_LIBRARY_PATH
ENV MANPATH=$MPICH_DIR/share/man:$MANPATH

RUN pip3 install mpi4py
RUN pip3 install neuron
RUN pip3 install git+https://github.com/LFPy/LFPy.git@master#egg=LFPy
