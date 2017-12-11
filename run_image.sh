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
}

show_usage

# Get docker machine IP if exists.
if [ x$(docker-machine ls --quiet) == "x" ]
then
    machine_ip="localhost"
else
    machine_ip=$(docker-machine ip default)
fi

if [ $# == 0 ]
then
    echo
    echo "------------------------------------------------------------"
    echo "The external directory is mounted under /workspace/external."
    echo "------------------------------------------------------------"
    echo 
    docker run -it -v $(pwd)/external:/workspace/external "${image_name}" bash
elif [ $# == 1 ] && [ $1 == "notebook" ]
then
    echo
    echo "------------------------------------------------------------"
    echo "The external directory is mounted under /workspace/external."
    echo "To quit Jupyter, press ctrl-c twice."
    echo "------------------------------------------------------------"
    echo
    docker run -it -p 8888:8888 -v $(pwd)/external:/workspace/external "${image_name}" | sed s/localhost/${machine_ip}/g
else
    echo
    echo "------------------------------------------------------------"
    echo "The external directory is mounted under /workspace/external."
    echo "------------------------------------------------------------"
    echo 
    docker run -it -v $(pwd)/external:/workspace/external "${image_name}" "$@"
fi
