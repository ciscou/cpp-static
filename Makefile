all: deploy

build:
	bundle exec middleman build

deploy: build
	gsutil -m cp -r build gs://ceramicapadilla.es

.PHONY: build deploy
