all: deploy

build:
	bundle exec middleman build

deploy: build
	scp -r build/* u68876391@home415006074.1and1-data.host:/kunden/homepages/22/d415006074/htdocs

.PHONY: build deploy
