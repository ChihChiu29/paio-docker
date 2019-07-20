#! /usr/bin/env bash

if [ $# == 0 ]
then
  echo "Usage: itests.sh <directory>"
  exit -1
else
  nosetests
  while inotifywait -r -e modify deep_learning/engine/
  do
    echo
    echo
    echo
    echo "===================================================================================================="
    nosetests
  done
fi
