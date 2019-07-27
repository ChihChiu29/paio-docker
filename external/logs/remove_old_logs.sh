#!/usr/bin/env bash

# Remove logs that are more than 30 days old:
find . -type f -name '*.txt' -mtime +30 -exec rm {} \;
