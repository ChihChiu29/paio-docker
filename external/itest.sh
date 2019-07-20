#! /usr/bin/env bash

if [ $# == 0 ]
then
  echo "Usage: itests.sh <directory>"
  exit -1
else
  while inotifywait -r -e modify deep_learning/engine/; do echo "===== CHANGE DETECTED ====="; nosetests; done
fi
