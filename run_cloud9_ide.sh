#! /usr/bin/env bash
image_name="chihchiu29/cloud9"

echo
echo "------------------------------------------------------------"
echo "The external directory is mounted under /workspace/external."
echo "Access at port 8887."
echo "To quit, use docker kill."
echo "------------------------------------------------------------"
echo
docker run -it -d -p 8887:80 -v $(pwd)/external/:/workspace/ "${image_name}"
