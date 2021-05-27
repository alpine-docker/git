RELEASE_TYPE ?= patch
SEMVER_IMAGE ?= alpine/semver

BUILDX_VER=v0.5.1

CURRENT_VERSION := $(shell git tag -l -n [0-9]* | sort --version-sort -r | awk 'NR==1{print $$1}' )

ifndef CURRENT_VERSION
  CURRENT_VERSION := 0.0.0
endif

NEXT_VERSION := $(shell docker run --rm $(SEMVER_IMAGE) semver -c -i $(RELEASE_TYPE) $(CURRENT_VERSION))

BRANCH = $(shell git rev-parse --abbrev-ref HEAD)

.PHONY: all current-version next-version release
all: release

current-version:
	@echo $(CURRENT_VERSION)

next-version:
	@echo $(NEXT_VERSION)

release:
	if [ "$(BRANCH)" = "master" ];then \
	  git tag $(NEXT_VERSION) ;\
	  git push --tags ;\
	fi

install:
	mkdir -vp ~/.docker/cli-plugins/ ~/dockercache
	curl --silent -L "https://github.com/docker/buildx/releases/download/${BUILDX_VER}/buildx-${BUILDX_VER}.linux-amd64" > ~/.docker/cli-plugins/docker-buildx
	chmod a+x ~/.docker/cli-plugins/docker-buildx

build-push:
	bash ./build.sh
