# use Alpine Linux:3.21.3 as base image
FROM alpine:3.21.3

# set timezone
ENV TZ=Asia/Tokyo

# install required packages
RUN apk update && apk add --no-cache \
    bash \
    build-base \
    clang \
    clang-extra-tools \
    cmake \
    cppcheck \
    curl \
    doxygen \
    fd \
    fzf \
    g++ \
    gcc \
    gdb \
    gettext-dev \
    git \
    lazygit \
    linux-headers \
    make \
    musl-dev \
    ncurses-dev \
    neovim \
    neovim-doc \
    nerd-fonts \
    pkgconfig \
    python3-dev \
    ripgrep \
    sudo \
    valgrind \
    zoxide \
    yadm \
    openssh \
    zsh

# create .config directory and clone LazyVim
WORKDIR /root

RUN mkdir -p /root/.config && \
    git clone https://github.com/LazyVim/starter /root/.config/nvim && \
    rm -rf /root/.config/nvim/.git

# set default shell to zsh
SHELL ["/bin/bash", "-c"]

# the command which starts at container startup
CMD ["/bin/bash"]
