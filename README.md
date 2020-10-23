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
