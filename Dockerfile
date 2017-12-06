FROM selenium/standalone-chrome:latest

MAINTAINER Chih Chiu <chih.chiu.19@gmail.com>

# Update and get aptitude.
RUN apt-get -y update && apt-get install -y aptitude
RUN aptitude upgrade -y


# System base.
RUN aptitude install -y cmake pkg-config
RUN aptitude install -y byobu wget
RUN aptitude install -y emacs-nox nano ne
RUN aptitude install -y git git-completion


# Python Scientific libraries.
RUN aptitude install -y python-dev python-pip python-numpy python-scipy python-matplotlib python-sympy


# ML/DL libraries.
RUN aptitude install -y python-scikits-learn
RUN pip install keras


# NLP
RUN aptitude install -y python-nltk
RUN pip install spacy nltk


# Web scraping
RUN aptitude install -y python-scrapy python-beautifulsoup


# Apt clean up
RUN apt-get -y clean
RUN apt-get -y autoclean


# Config/Environment setup.
WORKDIR "/workspace"
COPY data/dot_bashrc /root/.bashrc
COPY data/dot_emacs /root/.emacs
