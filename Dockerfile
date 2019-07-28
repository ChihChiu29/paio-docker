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


# Image and Video
RUN apt install -y imagemagick ffmpeg
RUN rm /etc/ImageMagick-6/policy.xml
COPY data/imagemagick_policy.xml /etc/ImageMagick-6/policy.xml


# Python Scientific libraries.
RUN pip install numpy scipy matplotlib pandas
RUN pip install jupyter jupyterlab
RUN pip install statsmodels
RUN pip install --upgrade Cython
RUN pip install --upgrade git+https://github.com/statsmodels/statsmodels


# ML/DL/RL libraries.
RUN pip install scikit-learn keras torch torchvision Theano
RUN pip install gym gym[box2d] gym-starter-kit gym-risk atari-py
RUN pip install gym-retro gym-tetris gym-sudoku


# Text Processing
RUN pip install spacy nltk textblob tweepy vaderSentiment googletrans
RUN apt install -y tesseract-ocr-eng
RUN pip install pytesseract


# Other Python libraries
RUN pip install flask retrying joblib absl-py cloudpickle jsonpickle JSAnimation websocket-client nose
RUN apt install -y python3-bs4 inotify-tools


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


# Chromium and Selenium WebDriver
RUN apt -y install chromium-browser
RUN apt -y install chromium-driver
RUN pip install selenium
RUN apt -y install xautomation

# Firefox and webdriver
# RUN apt -y install firefox
# ARG GECKODRIVER_VERSION=latest
# RUN GK_VERSION=$(if [ ${GECKODRIVER_VERSION:-latest} = "latest" ]; then echo "0.24.0"; else echo $GECKODRIVER_VERSION; fi) \
#  && echo "Using GeckoDriver version: "$GK_VERSION \
#  && wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GK_VERSION/geckodriver-v$GK_VERSION-linux64.tar.gz \
#  && rm -rf /opt/geckodriver \
#  && tar -C /opt -zxf /tmp/geckodriver.tar.gz \
#  && rm /tmp/geckodriver.tar.gz \
#  && mv /opt/geckodriver /opt/geckodriver-$GK_VERSION \
#  && chmod 755 /opt/geckodriver-$GK_VERSION \
#  && ln -fs /opt/geckodriver-$GK_VERSION /usr/bin/geckodriver


# Misc
RUN apt install -y graphviz libgraphviz-dev cron
RUN pip install graphviz ipywidgets snakeviz
# Some latex packages that help to export notebooks into pdfs.
RUN apt install -y apt texlive-xetex


# Apt clean up
RUN apt-get -y clean
RUN apt-get -y autoclean


# Config/Environment setup.
COPY data/dot_bashrc /root/.bashrc
COPY data/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
RUN mkdir -p /root/.keras/
COPY data/dot_keras__keras.json /root/.keras/keras.json
RUN jupyter nbextension enable --py widgetsnbextension
RUN mkdir -p /root/.ipython/profile_default/startup/
COPY data/notebook_init_loader.py /root/.ipython/profile_default/startup
WORKDIR "/workspace/external"

# Default command.
# Enable if X-forward is no longer used.
# CMD xvfb-run -s "-screen 0 1400x900x24"\
# CMD jupyter lab --port=8888 --allow-root
CMD /bin/bash /workspace/external/startme.sh
