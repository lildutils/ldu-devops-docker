VERSION := $(shell cat VERSION)

.PHONY: clean
clean:
	(rm -rf ./dist/latest/ ; \
	 rm -rf ./dist/${VERSION}/)

.PHONY: build
build:
	((mkdir -p ./dist/${VERSION}/) ; \
	 (mkdir -p ./dist/${VERSION}/docker/) ; \
	 (mkdir -p ./dist/${VERSION}/devops/) ; \
	 (find ./src/main/resources/ -name 'docker-*.env' -exec cp "{}" ./dist/${VERSION}/docker/ \;) ; \
	 (find ./src/main/resources/ -name 'docker-*.yml' -exec cp "{}" ./dist/${VERSION}/docker/ \;) ; \
	 (find ./src/main/sh/ -name 'make.sh' -exec cp "{}" ./dist/${VERSION}/devops/make.sh \;) ; \
	 (cp -r ./dist/${VERSION}/ ./dist/latest/))
