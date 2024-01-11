ARG VERSION

FROM lscr.io/linuxserver/code-server:${VERSION}

RUN echo "**** install libraries ****" && \
  apt-get install -y \
    build-essential gdb lcov pkg-config \
    libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
    libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
    lzma lzma-dev tk-dev uuid-dev zlib1g-dev && \

  echo "**** install vscode extensions ****" && \
    # Common
    install-extension editorconfig.editorconfig && \
    install-extension tamasfe.even-better-toml && \
    install-extension redhat.vscode-yaml && \
    install-extension eamodio.gitlens && \
    # Themes
    install-extension jolaleye.horizon-theme-vscode && \
    install-extension emmanuelbeziat.vscode-great-icons && \
    # Python development
    install-extension ms-python.python && \
    install-extension ms-python.mypy-type-checker && \
    install-extension charliermarsh.ruff && \

  echo "**** install python packages ****" && \
    python3 -m pip install --no-cache-dir --quiet -U pip && \
    python3 -m pip install --no-cache-dir --quiet -U poetry
