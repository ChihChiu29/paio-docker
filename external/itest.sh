#! /usr/bin/env bash

if [ $# == 0 ]
then
  echo "Usage: itests.sh <directory>"
  exit -1
else
  nosetests -v --nologcapture; echo "Watching changes in $1..."
  while inotifywait -r -e modify $1
  do
    echo
    echo
    echo
    echo "===================================================================================================="
    nosetests -v --nologcapture; echo "Watching changes in $1..."
  done
fi
