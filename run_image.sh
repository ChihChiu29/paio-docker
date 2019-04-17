#! /usr/bin/env bash
image_name="chihchiu29/paio-docker"

function show_usage() {
    echo
    echo "------------------------------------------------------------"
    echo "Usage reference:"
    echo "1) Run without arugments to start bash in docker."
    echo "2) Run with subcommand \"notebook\" to start Jupyter."
    echo "3) Run with other subcommands to run them in docker."
    echo "------------------------------------------------------------"
    echo
    if [ x$(which docker-machine) != "x" ] && [ x$(docker-machine ls --quiet) != "x" ]; then
      echo "IP: $(docker-machine ip default)"
    fi
}

show_usage


IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
if [ "x${IP}" == "x" ]; then
    DISP=$DISPLAY
else
    DISP=$IP:0
fi

xhost +
flags="-it -p 8888:8888 -e DISPLAY=$DISP -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd)/external:/workspace/external ${image_name}"

if [ $# == 0 ]
then
    echo
    echo "------------------------------------------------------------"
    echo "The external directory is mounted under /workspace/external."
    echo "------------------------------------------------------------"
    echo 
    docker run ${flags} bash
elif [ $# == 1 ] && [ $1 == "lab" ]
then
    echo
    echo "------------------------------------------------------------"
    echo "The external directory is mounted under /workspace/external."
    echo "To quit Jupyter, press ctrl-c twice."
    echo "------------------------------------------------------------"
    echo
    docker run ${flags}
else
    echo
    echo "------------------------------------------------------------"
    echo "The external directory is mounted under /workspace/external."
    echo "------------------------------------------------------------"
    echo 
    docker run ${flags} "$@"
fi
