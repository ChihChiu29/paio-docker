#! /usr/bin/env bash
image_name="chihchiu29/paio-docker"

function show_usage() {
    echo
    echo "------------------------------------------------------------"
    echo "Usage reference:"
    echo "- Run without arugments to start Jupyter."
    echo "- Run with any other arguments will execute them in the docker image environment."
    echo "The external directory is mounted in the image under /workspace/external."
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
    echo "To quit Jupyter, press ctrl-c twice."
    echo "------------------------------------------------------------"
    echo
    docker run -it -p 8888:8888 -v $(pwd)/external:/workspace/external "${image_name}" | sed s/localhost/${machine_ip}/g
else
    echo
    echo "------------------------------------------------------------"
    echo "If you need to run a server, use port 8888 and it can be "
    echo "accessed on host at http://${machine_ip}:8888"
    echo "------------------------------------------------------------"
    echo 
    docker run -it -p 8888:8888 -v $(pwd)/external:/workspace/external "${image_name}" "$@"
fi
