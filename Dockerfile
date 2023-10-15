# syntax=docker/dockerfile:1

FROM python:3.9.7-buster

COPY clean-layer.sh  /tmp/clean-layer.sh
RUN chmod +x /tmp/clean-layer.sh
COPY requirements.txt .

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9

RUN apt-get -y update && \
  apt-get install -y locales && \
  localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
  apt-get install -y fonts-noto-cjk

RUN apt-get install -y mecab mecab-ipadic-utf8 libmecab-dev && \
  apt-get install -y git make curl xz-utils file sudo

# mecab-ipadic-NEologdのインストール
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
  cd mecab-ipadic-neologd && \
  ./bin/install-mecab-ipadic-neologd -n -y && \
  echo dicdir = `mecab-config --dicdir`"/mecab-ipadic-neologd">/etc/mecabrc && \
  sudo cp /etc/mecabrc /usr/local/etc && \
  cd ..
  
# python ライブラリのインストール
RUN python -m pip install -r requirements.txt