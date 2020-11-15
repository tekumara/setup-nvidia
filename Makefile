MAKEFLAGS += --warn-undefined-variables
SHELL = /bin/bash -o pipefail
.DEFAULT_GOAL := help
.PHONY: help docker-build

## display help message
help:
	@awk '/^##.*$$/,/^[~\/\.0-9a-zA-Z_-]+:/' $(MAKEFILE_LIST) | awk '!(NR%2){print $$0p}{p=$$0}' | awk 'BEGIN {FS = ":.*?##"}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' | sort

## build the docker image
build:
	docker build . -t ubuntu-nvidia

## run latest docker image
run:
	docker run --rm -it ubuntu-nvidia:latest

## test install.sh download
test-download:
	docker build . -f Dockerfile.download

## tag the current commit as latest
tag:
	git tag -f latest && git push --tags -f
