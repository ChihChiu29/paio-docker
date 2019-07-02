#! /usr/bin/env bash
# image_name="chihchiu29/paio-docker"
image_name="test"

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

port_flags='-p 8888:8888 -p 8080:8080 -p 5000:5000 -p 8000:8000 -p 80:80 -p 9222:9222'
flags="-it -e DISPLAY=$DISP -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd)/external:/workspace/external ${image_name}"

echo
echo "------------------------------------------------------------"
echo "The external directory is mounted under /workspace/external."
echo "------------------------------------------------------------"
echo
xhost +
echo "Running: docker run ${port_flags} ${flags} /workspace/external/startme.sh $@"
docker run ${port_flags} ${flags} /workspace/external/startme.sh "$@"