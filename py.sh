#! /usr/bin/env bash
# Runs a python3 module from inside the docker image, using root path /workspace/external.
image_name="chihchiu29/paio-docker"

if [ $# == 0 ]
then
    echo "Usage: py.sh <python module (root path /workspace/external)>"
    exit 0
else
    IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
    if [ "x${IP}" == "x" ]; then
        DISP=$DISPLAY
    else
        DISP=$IP:0
    fi
    docker run -it -e DISPLAY=$DISP -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd)/external:/workspace/external ${image_name} python3 -m "$@"
fi
