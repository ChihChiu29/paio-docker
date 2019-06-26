#! /usr/bin/env bash
# Shortcut to join a running paio-docker image.

containerId=$(docker ps | grep paio | cut -d " " -f 1)
docker exec -it ${containerId} bash
