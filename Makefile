AWS_BUCKET            = s3://ceramicapadilla.es
AWS_REGION            = eu-west-3
BUILD_DIR             = build
CACHE_FOREVER         = --cache-control="max-age=1576800000"
NO_CACHE              = --cache-control="max-age=0, no-cache"
ASSETS_ONLY           = --exclude "*" --include "*.js" --include "*.css" --include "*.jpg" --include "*.png" --include "*.ttf" --include "*.woff" --include "*.svg" --include "*.eot"
HTML_ONLY             = --exclude "*" --include "*.html"
AWS_COMMAND           = aws s3 sync ${BUILD_DIR}/ ${AWS_BUCKET}/ --region ${AWS_REGION} --acl=public-read --delete
DEPLOY_ASSETS_COMMAND = ${AWS_COMMAND} ${CACHE_FOREVER} ${ASSETS_ONLY}
DEPLOY_HTML_COMMAND   = ${AWS_COMMAND} ${NO_CACHE} ${HTML_ONLY}

all: deploy

build:
	bundle exec middleman build

deploy: build
	${DEPLOY_ASSETS_COMMAND}
	${DEPLOY_HTML_COMMAND}

.PHONY: build deploy
