#! /usr/bin/env bash
# This script is run automatically when the image is run (by run_image.sh).

# Start cron jobs from external/cronjobs.cron.
#
# 1. Create a single script to execute the command you want to execute.
#   1a. Remember to use `date` and `>` to create logs for execution times and logs, example:
#       #! /usr/bin/env bash
#       cd /workspace/external/
#       suffix=$(date +"%Y%m%d-%H%M%S")
#       python3 -m stockfun.scripts.download_today_ratings > ./logs/download_today_ratings_logs_${suffix}.txt 2>&1
# 2. Add the script to external/cronjobs. The following example executes a
#    script every 6 hours and allows to open GUI:
#    0 */6 * * * export DISPLAY=:0 && /bin/bash /workspace/external/stockfun/scripts/download_ratings_cron.sh
service cron start
cd /workspace/external
if [ -e cronjobs.cron ]
then
  crontab cronjobs.cron
fi

# Process startup commands.
if [ $# == 0 ]
then
    bash
elif [ $# == 1 ] && [ $1 == "lab" ]
then
    jupyter lab --port=8888 --allow-root
elif [ $# == 1 ] && [ $1 == "notebook" ]
then
    jupyter notebook --port=8888 --allow-root
else
    exec "$@"
fi
