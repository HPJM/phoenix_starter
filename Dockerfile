FROM ubuntu:focal

WORKDIR /app

RUN apt-get update && apt-get install -y curl locales

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV HOME=/root
ENV PATH="$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH"
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y git \
    # Erlang dependencies
    build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-dev \
    libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils \
    libncurses-dev openjdk-11-jdk

# Install asdf
RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.10.0

# Install nodejs
RUN asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git && \
    asdf install nodejs 16.15.1 && \
    asdf global nodejs 16.15.1 && \
    rm -rf /tmp/*

# Install erlang
RUN asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git && \
    asdf install erlang 25.0.2 && \
    asdf global erlang 25.0.2 && \
    rm -rf  /tmp/*

# Install elixir
RUN asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git && \
    asdf install elixir 1.13.4-otp-25 && \
    asdf global elixir 1.13.4-otp-25 && \
    rm -rf  /tmp/*

# Install hex and rebar
RUN mix local.hex --force
RUN mix local.rebar --force