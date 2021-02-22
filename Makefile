all: deploy

build:
	bundle exec middleman build

deploy: build
	gsutil -m cp -r build/* gs://ceramicapadilla.es
	gsutil setmeta -h "Cache-Control: max-age=0, no-cache" gs://ceramicapadilla.es/**.html

.PHONY: build deploy
