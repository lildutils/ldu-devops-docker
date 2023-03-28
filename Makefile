VERSION := $(shell cat VERSION)

.PHONY: clean
clean:
	(rm -rf ./dist/latest/ ; \
	 rm -rf ./dist/${VERSION}/)

.PHONY: build
build:
	((rm -rf ./build/) ; \
	 (mkdir -p ./build/${VERSION}/docker/) ; \
	 (find ./src/main/resources/ -name 'docker-*.env' -exec cp "{}" ./build/${VERSION}/docker/ \;) ; \
	 (find ./src/main/resources/ -name 'docker-*.yml' -exec cp "{}" ./build/${VERSION}/docker/ \;) ; \
	 (cp ./LICENSE ./build/${VERSION}/) ; \
	 (find ./src/main/sh/ -name 'make.sh' -exec cp "{}" ./build/${VERSION}/make.sh \;) ; \
	 (cp ./README.md ./build/${VERSION}/) ; \
	 (cp ./VERSION ./build/${VERSION}/) ; \
	 (cp -r ./build/${VERSION}/ ./dist/${VERSION}/) ; \
	 (cp -r ./dist/${VERSION}/ ./dist/latest/))
