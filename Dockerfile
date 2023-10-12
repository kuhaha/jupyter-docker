# syntax=docker/dockerfile:1

FROM python:3.9.7-buster

ADD clean-layer.sh  /tmp/clean-layer.sh

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9

RUN apt-get -y update && \
  apt install -y locales && \
  localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
  apt install -y fonts-noto-cjk && \
  /tmp/clean-layer.sh

RUN apt-get install -y mecab mecab-ipadic-utf8 libmecab-dev && \
  apt-get install -y git make curl xz-utils file sudo && \
  /tmp/clean-layer.sh

# mecab-ipadic-NEologdのインストール
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
  cd mecab-ipadic-neologd && \
  ./bin/install-mecab-ipadic-neologd -n -y && \
  echo dicdir = `mecab-config --dicdir`"/mecab-ipadic-neologd">/etc/mecabrc && \
  sudo cp /etc/mecabrc /usr/local/etc && \
  cd .. && \
  /tmp/clean-layer.sh

# python ライブラリのインストール
RUN python -m pip install pandas
RUN python -m pip install scikit-learn
RUN python -m pip install matplotlib
RUN python -m pip install jupyterlab
RUN python -m pip install notebook
RUN python -m pip install mecab-python3
RUN python -m pip install janome
RUN python -m pip install nlplot plotly
