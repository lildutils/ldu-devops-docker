VERSION := $(shell cat VERSION)

.PHONY: clean
clean:
	(rm -rf ./dist/latest/ ; \
	 rm -rf ./dist/${VERSION}-SNAPSHOT/ ; \
	 rm -rf ./dist/${VERSION}a/ ; \
	 rm -rf ./dist/${VERSION}b/ ; \
	 rm -rf ./dist/${VERSION}/)

.PHONY: build
build:
	((rm -rf ./build/) ; \
	 (mkdir -p ./build/docker/) ; \
	 (find ./src/main/resources/ -name 'docker-*.env' -exec cp "{}" ./build/docker/ \;) ; \
	 (find ./src/main/resources/ -name 'docker-*.yml' -exec cp "{}" ./build/docker/ \;) ; \
	 (cp ./LICENSE ./build/) ; \
	 (find ./src/main/sh/ -name 'make.sh' -exec cp "{}" ./build/make.sh \;) ; \
	 (cp ./README.md ./build/) ; \
	 (cp ./VERSION ./build/) ; \
	 (cp -r ./build/ ./dist/${VERSION}/) ; \
	 (cp -r ./dist/${VERSION}/ ./dist/latest/))
