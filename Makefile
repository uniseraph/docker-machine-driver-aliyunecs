SHELL = /bin/bash

TARGET       = docker-machine-driver-aliyunecs
PROJECT_NAME = github.com/uniseraph/docker-machine-driver-aliyunecs

MAJOR_VERSION = $(shell cat VERSION)
GIT_VERSION   = $(shell git log -1 --pretty=format:%h)
GIT_NOTES     = $(shell git log -1 --oneline)

BUILD_IMAGE    = acs-reg.alipay.com/acs/build:1.5.1
IMAGE_NAME     = acs-reg.alipay.com/acs/docker-machine-driver-aliyunecs


build-local:
	CGO_ENABLED=0 $(shell which godep) go build -a -installsuffix cgo -v -o ${TARGET}
build:
	docker build --rm -t ${BUILD_IMAGE} contrib/builder/binary
	docker run --rm -v $(shell pwd):/go/src/${PROJECT_NAME} -w /go/src/${PROJECT_NAME} ${BUILD_IMAGE} make build-local
build-image: build
	docker build --rm -t ${IMAGE_NAME}:${MAJOR_VERSION}-${GIT_VERSION} .
	docker tag -f ${IMAGE_NAME}:${MAJOR_VERSION}-${GIT_VERSION} ${IMAGE_NAME}:latest
	docker push ${IMAGE_NAME}:latest



.PHONY: build-image build build-local
