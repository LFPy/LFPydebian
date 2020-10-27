FROM debian:latest

ENV OMPI_DIR=/opt/ompi
ENV SINGULARITY_OMPI_DIR=$OMPI_DIR
ENV SINGULARITYENV_APPEND_PATH=$OMPI_DIR/bin
ENV SINGULARITYENV_APPEND_LD_LIBRARY_PATH=$OMPI_DIR/lib

RUN apt-get update && \
    apt-get install -y \
        wget \
        bash \
        build-essential \
        make \
        gcc \
        g++ \
        gfortran \
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

ENV OMPI_VERSION=4.0.1
ENV OMPI_URL="https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-$OMPI_VERSION.tar.bz2"
RUN mkdir -p /tmp/ompi
RUN mkdir -p /opt

RUN cd /tmp/ompi && wget -O openmpi-$OMPI_VERSION.tar.bz2 $OMPI_URL && tar -xjf openmpi-$OMPI_VERSION.tar.bz2
RUN cd /tmp/ompi/openmpi-$OMPI_VERSION && ./configure --prefix=$OMPI_DIR && make install

ENV PATH=$OMPI_DIR/bin:$PATH
ENV LD_LIBRARY_PATH=$OMPI_DIR/lib:$LD_LIBRARY_PATH
ENV MANPATH=$OMPI_DIR/share/man:$MANPATH

RUN pip3 install mpi4py
RUN pip3 install neuron
RUN pip3 install git+https://github.com/LFPy/LFPy.git@master#egg=LFPy
