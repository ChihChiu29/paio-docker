#!/usr/bin/env bash

# Remove logs that are more than 7 days old:
find /path/to/files/ -type f -name '*.txt' -mtime +7 -exec rm {} \;
