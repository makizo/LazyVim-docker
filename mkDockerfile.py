import os
import getpass

# カレントユーザー名を取得
current_user = getpass.getuser()

# Dockerfileの内容を作成
dockerfile_content = f"""FROM alpine:3.21.3

# タイムゾーンを設定
ENV TZ=Asia/Tokyo

# 必要なパッケージをインストール
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
    shadow \
    sudo \
    tzdata \
    valgrind \
    zoxide \
    yadm \
    openssh \
    zsh

# ユーザーを作成（ホームディレクトリも同時に作成、シェルをbashに設定）
RUN useradd -m -s /bin/bash {current_user}

# 作成したユーザーに切り替え
USER {current_user}

# ワーキングディレクトリをユーザーのホームディレクトリに設定
WORKDIR /home/{current_user}
RUN mkdir -p /home/{current_user}/.config && \
    git clone https://github.com/LazyVim/starter /home/{current_user}/.config/nvim && rm -rf /home/{current_user}/.config/nvim/.git

# デフォルトコマンドをbashに設定
CMD ["/bin/bash"]
"""

# Dockerfileを作成
with open('Dockerfile', 'w') as f:
    f.write(dockerfile_content)

print(f"Dockerfileを作成しました。")
print(f"カレントユーザー名: {current_user}")
# print("\n--- Dockerfile内容 ---")
# print(dockerfile_content)
