FROM debian:11-slim

RUN echo "**** install libraries ****" && \
  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    aria2 \
    build-essential \
    curl \
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
    python3-pip \
    sudo \
    tk-dev \
    uuid-dev \
    wget \
    zlib1g-dev && \
  echo "**** install python packages ****" && \
    python3 -m pip install -U pip && \
    python3 -m pip install \
      poetry \
      tox && \
  echo "**** install VS Code (code-server) ****" && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
  echo "**** cleanup ****" && \
    apt-get clean && \
    rm -rf \
      /tmp/* \
      /var/lib/apt/lists/* \
      /var/tmp/*

RUN echo "**** add developer user ****" && \
  useradd -ms /bin/bash clayman && \
  echo 'clayman:clayman' | chpasswd

USER clayman

WORKDIR /home/clayman

ENV PYENV_ROOT /home/clayman/.pyenv

RUN echo "**** install pyenv ****" && \
    git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv && \
  echo "**** install python versions ****" && \
    $HOME/.pyenv/bin/pyenv install 3.10 && \
    $HOME/.pyenv/bin/pyenv install 3.11 && \
    $HOME/.pyenv/bin/pyenv install 3.12 && \
  echo "**** configure poetry ****" && \
    poetry config virtualenvs.create false

RUN echo "**** install VS Code extensions ****" && \
    code-server \
      # Common extensions
      --install-extension redhat.ansible \
      --install-extension redhat.vscode-yaml \
      --install-extension alefragnani.bookmarks \
      --install-extension editorconfig.editorconfig \
      --install-extension tamasfe.even-better-toml \
      --install-extension eamodio.gitlens \
      --install-extension mutantdino.resourcemonitor \
      # Theme
      --install-extension jolaleye.horizon-theme-vscode \
      --install-extension emmanuelbeziat.vscode-great-icons \
      # Python development
      --install-extension ms-python.python \
      --install-extension ms-python.mypy-type-checker \
      --install-extension cameron.vscode-pytest \
      --install-extension charliermarsh.ruff

EXPOSE 5000

ENTRYPOINT ["code-server"]

CMD ["--bind-addr", "0.0.0.0:5000"]
