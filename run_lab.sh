#! /usr/bin/env bash

echo "======================================================"
echo "  WARNING: WILL STOP ALL RUNNING IMAGES AFTERWARDS    "
echo "======================================================"

# Start Cloud9 editor.
./run_cloud9_ide.sh

# Start main image and run lab (blocking).
./run_image.sh lab

# Turn down all running images.
./utilities/stopall.sh