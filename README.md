# LFPydebian

[![Docker](https://img.shields.io/badge/Docker-yes-green.svg)](https://hub.docker.com/r/lfpy/lfpydebian)

## Debian + LFPy Docker recipe

We provide a Docker (https://www.docker.com) container build file with LFPy.
To get started, install Docker and issue either:

    $ docker pull lfpy/lfpydebian
    $ docker run -it -p 5000:5000 lfpy/lfpydebian

or

    $ docker build -t lfpy https://raw.githubusercontent.com/LFPy/LFPydebian/main/Dockerfile
    $ docker run -it -p 5000:5000 lfpy

The ``--mount`` option can be used to mount a folder on the host to a target folder as:

    $ docker run --mount type=bind,source="$(pwd)",target=/opt -it -p 5000:5000 lfpy/lfpydebian

which mounts the present working dirctory (``$(pwd)``) to the ``/opt`` directory of the container.
Try mounting the ``LFPy`` source directory (``git clone https://github.com/LFPy/LFPy.git``) for example (by setting ``source="<path-to-LFPy>"``). Various LFPy example files can then be found in the folder ``/opt/LFPy/examples/``
when the container is running.

Jupyter notebook servers running from within the
container can be accessed after invoking them by issuing:

    $ cd /opt/LFPy/examples/
    $ jupyter notebook --ip 0.0.0.0 --port=5000 --no-browser --allow-root

and opening the resulting URL in a browser on the host computer, similar to:
http://127.0.0.1:5000/?token=dcf8f859f859740fc858c568bdd5b015e0cf15bfc2c5b0c1

## Docker recipes for Singularity/HPC computing

We provide modified container recipes suitable for high-performance computing (HPC) facilities,
that are either using the ``MPICH`` or ``OpenMPI`` library using the `hybrid` model of
Singularity (https://sylabs.io/guides/3.6/user-guide/index.html),
see https://sylabs.io/guides/3.6/user-guide/mpi.html#hybrid-model for details.

These recipes are ``mpich.Dockerfile`` and ``openmpi.Dockerfile`` for ``mpiexec`` and ``mpirun``, respectively.

How to configure the build may depend on tools available on the compute cluster.
For one example, see https://gitlab.version.fz-juelich.de/bvonstvieth_publications/container_userdoc_tmp.

After building, LFPy python code can be executed in parallel as

    $ <mpi-executable> singularity exec <container-file> python3 -u <myscript.py>
