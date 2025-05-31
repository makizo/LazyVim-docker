# use Alpine Linux:3.21.3 as base image.
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
    zsh

# make user dir
RUN mkdir -p /home/user
WORKDIR /home/user
RUN git clone https://github.com/LazyVim/starter ~/.config/nvim
RUN rm -rf ~/.config/nvim/.git

# set default shell to bash ( in Alpine Linux, default shell is 'ash')
### RUN apk add --no-cache bash
SHELL ["/bin/bash", "-c"]

# the command which is start at start of container
CMD ["/bin/bash"]
