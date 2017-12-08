#! /usr/bin/env bash
docker ps -a -q | xargs docker stop
docker ps -a -q | xargs docker rm