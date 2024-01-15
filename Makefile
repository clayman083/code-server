.PHONY: build

NAME		:= ghcr.io/clayman083/code-server
VERSION		?= latest

build:
	docker build -t ${NAME} .
	docker tag ${NAME} ${NAME}:$(VERSION)
