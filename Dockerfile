# use Alpine Linux:3.21.3 as base image
FROM alpine:3.21.3

# set timezone
ENV TZ=Asia/Tokyo

# install required packages
RUN apk update && apk add --no-cache \
    build-base \
    gcc \
    g++ \
    make \
    cmake \
    gdb \
    valgrind \
    git \
    clang \
    clang-extra-tools \
    cppcheck \
    doxygen \
    pkgconfig \
    linux-headers \
    musl-dev \
    ncurses-dev \
    python3-dev \
    gettext-dev \
    bash \
    neovim \
    zsh \
    fd \
    ripgrep \
    lazygit \
    curl \
    fzf \
    nerd-fonts-all \
    sudo

# create .config directory and clone LazyVim
WORKDIR /root

RUN mkdir -p /root/.config && \
    git clone https://github.com/LazyVim/starter /root/.config/nvim && \
    rm -rf /root/.config/nvim/.git

# set default shell to bash
SHELL ["/bin/bash", "-c"]

# the command which starts at container startup
CMD ["/bin/bash"]
