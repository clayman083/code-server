FROM debian:11-slim

RUN echo "**** install libraries ****" && \
  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    gdb \
    git \
    lcov \
    libbz2-dev \
    libffi-dev \
    libgdbm-compat-dev \
    libgdbm-dev \
    liblzma-dev \
    libncurses5-dev \
    libreadline6-dev \
    libsqlite3-dev \
    libssl-dev \
    lzma \
    lzma-dev \
    pkg-config \
    python3-dev \
    tk-dev \
    uuid-dev \
    zlib1g-dev && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

ENV PYENV_ROOT /root/.pyenv

RUN echo "**** install pyenv ****" && \
  git clone https://github.com/pyenv/pyenv.git /root/.pyenv

RUN echo "**** install python versions ****" && \
  /root/.pyenv/bin/pyenv install 3.10 && \
  /root/.pyenv/bin/pyenv install 3.11 && \
  /root/.pyenv/bin/pyenv install 3.12
