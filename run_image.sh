#! /usr/bin/env bash
function show_usage() {
    echo
    echo "------------------------------------------------------------"
    echo "Usage reference:"
    echo "1. Run without arugments to start Jupyter."
    echo "2. Run with argument 'sshd' to start in daemon mode. SSH daemon will start."
    echo "3. Run with any other arguments will execute them in the docker image environment."
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
    docker run -it -p 8888:8888 -v $(pwd)/external:/workspace/external chihchiu29/ml-swiss-army-knife | sed s/localhost/${machine_ip}/g
elif [ $# == 1 ] && [ $1 == "sshd" ]
then
    container_name="ml-docker-daemon"
    docker run -d -P --name ${container_name} -v $(pwd)/external:/workspace/external chihchiu29/ml-swiss-army-knife /usr/sbin/sshd -D
    ssh_host_port=$(docker port ${container_name} 22 | sed s/0.0.0.0/${machine_ip}/g)
    echo
    echo "------------------------------------------------------------"
    echo "Connect to SSH daemon at root@${ssh_host_port}"
    echo "Use password 'toor'."
    echo "To stop daemon use command 'docker stop ${container_name}' then 'docker rm ${container_name}'."
    echo "------------------------------------------------------------"
    echo
else
    echo
    echo "------------------------------------------------------------"
    echo "Run server at port 8888 and access it at http://${machine_ip}:8888"
    echo "------------------------------------------------------------"
    echo 
    docker run -it -p 8888:8888 -v $(pwd)/external:/workspace/external chihchiu29/ml-swiss-army-knife "$@"
fi
