import os
import getpass

# カレントユーザー名を取得
current_user = getpass.getuser()

# Makefileの内容（f-stringで直接current_userを埋め込み）
makefile_content = f""".DEFAULT_GOAL := run

DOCKER=docker
IMAGE_NAME=lazyvim
CONTAINER_NAME=my_lazyvim
CURRENT_DIR := $(shell pwd)

.PHONY: build run clean stop

.build_stamp: Dockerfile
	test -f Dockerfile || (echo "Dockerfile not found" && exit 1)
	$(DOCKER) build -t $(IMAGE_NAME) .
	touch .build_stamp

build: .build_stamp

run: .build_stamp
	test -d $(CURRENT_DIR)/user || (echo "user directory not found" && exit 1)
	$(DOCKER) run -it --name $(CONTAINER_NAME) -v $(CURRENT_DIR)/user:/home/{current_user} -u {current_user} $(IMAGE_NAME)

clean:
	$(DOCKER) rmi $(IMAGE_NAME)
	rm -f .build_stamp

stop:
	$(DOCKER) stop $(CONTAINER_NAME) || true"""

print(f"カレントユーザー: {current_user}")
# print("\n--- f-stringで生成されたMakefile ---")
# print(makefile_content)

# ファイルに保存
with open('Makefile', 'w') as f:
    f.write(makefile_content)

