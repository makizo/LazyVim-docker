# ベースイメージとしてAlpine Linuxの最新版を使用
FROM alpine:3.21.3

# タイムゾーンの設定
ENV TZ=Asia/Tokyo

# 必要なパッケージのインストール
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

# Vimのビルドに必要な追加パッケージのインストール
### RUN apk add --no-cache \
###     ncurses-dev \
###     python3-dev \
###     gettext-dev

# Vimのソースコードをクローンしてビルド・インストール
### RUN git clone https://github.com/vim/vim.git /tmp/vim && \
###     cd /tmp/vim && \
###     ./configure \
###         --with-features=huge \
###         --enable-python3interp=yes \
###         --enable-multibyte \
###         --enable-fail-if-missing && \
###     make -j$(nproc) && \
###     make install && \
###     rm -rf /tmp/vim

# ユーザーディレクトリの作成
RUN mkdir -p /home/user
WORKDIR /home/user
RUN git clone https://github.com/LazyVim/startar ~/.config/nvim
RUN rm -rf ~/.config/nvim/.git

# デフォルトのシェルをbashに設定（Alpine Linuxではデフォルトでashを使用）
### RUN apk add --no-cache bash
SHELL ["/bin/bash", "-c"]

# コンテナ起動時のコマンド
CMD ["/bin/bash"]
