#! /usr/bin/env bash
# This script is run when the image is run.
# Start cron jobs.
service cron start
cd /workspace/external
if [ -e cronjobs.cron ]
then
  crontab cronjobs.cron
fi
