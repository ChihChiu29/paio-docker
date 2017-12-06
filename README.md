# ml-docker
For building chihchiu29/ml-swiss-army-knife image.

The image is meant to be the all-in-one image for ML/DL. It contains commonly used DL tools and engineering tools.

# Quickstart

* To start the docker image, use `run_image.sh`. It support the following running modes:
  - With no subcommand. This will start Jupyter.
  - With subcommand "sshd". This will start the container as a ssdh server.
  - With other subcommand. The subcommand will be executed in the container.
* To update the `chihchiu29/ml-swiss-army-knife` image, use `update_image.sh`.
* The `external` folder is mapped to `/workspace/external` in the container.

# Included Tools

## ML/DL

* numpy / scipy / sympy / pandas / matplotlib
* Jupyter (with widget enabled)
* TensorFlow
* scikit
* keras

## Image processing / NLP / Visualization tools

* OpenCV, tesseract, skimage
* nltk, spacy, mahotas
* scrapy
* graphviz, bokeh

## System tools

* git
* sshd
* byobu
* wget, curl
* emacs (nox), ne, nano
* zip

# Trouble Shooting

* No space left on device error (during running `update_image.sh`)
Try:
```
docker rm $(docker ps -q -f 'status=exited')
docker rmi $(docker images -q -f "dangling=true")
```
Then update again.
