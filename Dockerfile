FROM tensorflow/tensorflow:latest-py3

MAINTAINER Chih Chiu <chih.chiu.19@gmail.com>

# Update and get aptitude.
RUN apt-get -y update && apt-get install -y aptitude


# System base.
RUN aptitude install -y cmake libgtk2.0-dev pkg-config
RUN aptitude install -y python3-pip python-opengl
# Set variable to avoid interactive prompt during installation.
RUN DEBIAN_FRONTEND=noninteractive aptitude install -y python3-tk
RUN aptitude install -y byobu wget psmisc unzip zip
RUN aptitude install -y ne
RUN aptitude install -y git
RUN aptitude install -y xvfb swig
RUN rm /usr/local/bin/pip && ln -s `which pip3` /usr/local/bin/pip
RUN pip install --upgrade pip


# ImageMagick
RUN aptitude install -y imagemagick
RUN rm /etc/ImageMagick-6/policy.xml
COPY data/imagemagick_policy.xml /etc/ImageMagick-6/policy.xml


# Python Scientific libraries.
RUN pip install numpy scipy matplotlib pandas
RUN pip install jupyter jupyterlab
RUN pip install statsmodels
RUN pip install --upgrade Cython
RUN pip install --upgrade git+https://github.com/statsmodels/statsmodels



# ML/DL/RL libraries.
RUN pip install scikit-learn keras torch torchvision
RUN pip install gym gym-starter-kit gym-risk atari-py
RUN pip install gym-retro gym-tetris gym-sudoku
# Causing errors:
# gym-super-mario-bros


# Text Processing
RUN pip install spacy nltk textblob tweepy vaderSentiment


# Other libraries
RUN pip install flask retrying joblib absl-py cloudpickle jsonpickle JSAnimation


# PyCharm
RUN mkdir /opt/pycharm
ADD https://download.jetbrains.com/python/pycharm-community-2019.1.tar.gz /opt/pycharm/installer.tgz
RUN tar --strip-components=1 -xzf /opt/pycharm/installer.tgz && rm /opt/pycharm/installer.tgz

COPY data/dot_PyCharmCE2019.1.zip /root/
RUN unzip /root/dot_PyCharmCE2019.1.zip -d /root/
RUN rm /root/dot_PyCharmCE2019.1.zip
COPY data/dot_java.zip /root/
RUN unzip /root/dot_java.zip -d /root/
RUN rm /root/dot_java.zip


# Chrome and Selenium WebDriver
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get -y update && apt-get install -y google-chrome-stable

RUN wget -q --continue -P ~/ "http://chromedriver.storage.googleapis.com/$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip"
RUN unzip ~/chromedriver_linux64.zip -d /usr/local/bin
RUN rm ~/chromedriver_linux64.zip

RUN pip install selenium
RUN apt-get -y install xautomation


# Misc
RUN aptitude install -y graphviz libgraphviz-dev
RUN pip install graphviz ipywidgets


# Apt clean up
RUN apt-get -y clean
RUN apt-get -y autoclean


# Config/Environment setup.
WORKDIR "/workspace"
COPY data/dot_bashrc /root/.bashrc
COPY data/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
RUN jupyter nbextension enable --py widgetsnbextension
RUN mkdir -p /root/.ipython/profile_default/startup/
COPY data/notebook_init_loader.py /root/.ipython/profile_default/startup


# Default command.
CMD xvfb-run -s "-screen 0 1400x900x24"\
    jupyter lab --port=8888 --allow-root
