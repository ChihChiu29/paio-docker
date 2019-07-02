#! /usr/bin/env bash
# This script is run automatically when the image is run (by run_image.sh).

# Start cron jobs.
service cron start
cd /workspace/external
if [ -e cronjobs.cron ]
then
  crontab cronjobs.cron
fi

# Process commands.
if [ $# == 0 ]
then
    bash
elif [ $# == 1 ] && [ $1 == "lab" ]
then
    jupyter lab --port=8888 --allow-root
else
    exec "$@"
fi
