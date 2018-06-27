#! /usr/bin/env bash

echo "======================================================"
echo "  WARNING: WILL STOP ALL RUNNING IMAGES AFTERWARDS    "
echo "======================================================"

# Start Cloud9 editor.
./run_cloud9_ide.sh

# Start notebook image (blocking).
./run_image.sh notebook

# Turn down all running images.
./utilities/stopall.sh