FROM ubuntu:latest

MAINTAINER Chih Chiu <chih.chiu.19@gmail.com>

# Update and get aptitude.
RUN apt-get -y update && apt-get install -y aptitude


# System base.
RUN aptitude install -y cmake libgtk2.0-dev pkg-config
RUN aptitude install -y python3-pip
RUN aptitude install -y byobu wget psmisc unzip
RUN aptitude install -y ne
RUN aptitude install -y git
RUN ln -s `which pip3` /usr/local/bin/pip
RUN pip install --upgrade pip


# Python Scientific libraries.
RUN pip install numpy scipy matplotlib pandas
RUN pip install jupyter


# ML/DL libraries.
RUN pip install scikit-learn keras


# Text Processing
RUN pip install spacy nltk textblob


# Other libraries
RUN pip install retrying joblib absl-py jsonpickle


# Chrome and Selenium WebDriver
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get -y update && apt-get install -y google-chrome-stable

RUN wget -q --continue -P ~/ "http://chromedriver.storage.googleapis.com/$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip"
RUN unzip ~/chromedriver_linux64.zip -d /usr/local/bin
RUN rm ~/chromedriver_linux64.zip

RUN pip install selenium


# Misc
RUN aptitude install -y graphviz libgraphviz-dev
RUN pip install graphviz ipywidgets


# Apt clean up
# RUN apt-get -y clean
# RUN apt-get -y autoclean


# Config/Environment setup.
WORKDIR "/workspace"
COPY data/dot_bashrc /root/.bashrc
#RUN mkdir /root/.jupyter/
COPY data/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
RUN jupyter nbextension enable --py widgetsnbextension


# Default command.
CMD ["jupyter", "lab", "--allow-root"]
