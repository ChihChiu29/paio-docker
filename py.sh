#! /usr/bin/env bash
# Runs a python3 module from inside the docker image, using root path /workspace/external.
if [ $# == 0 ]
then
    echo "Usage: py.sh <python module (root path /workspace/external)>"
    exit 0
else
    ./run_image.sh bash -c "cd /workspace/external; python3 -m $@"
fi
