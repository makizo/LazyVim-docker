.DEFAULT_GOAL := run

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
	$(DOCKER) run -it --name $(CONTAINER_NAME) -v $(CURRENT_DIR)/user:/root -u root $(IMAGE_NAME)

clean:
	$(DOCKER) rmi $(IMAGE_NAME)
	rm -f .build_stamp

stop:
	$(DOCKER) stop $(CONTAINER_NAME) || true
