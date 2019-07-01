#! /usr/bin/env bash
service cron start
cd /workspace/external
crontab cronjobs.cron
