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
	 (mkdir -p ./build/resources/) ; \
	 (find ./src/main/resources/ -name '*.example' -exec cp "{}" ./build/resources/ \;) ; \
	 (find ./src/main/resources/ -name '*.yml' -exec cp "{}" ./build/resources/ \;) ; \
	 (cp ./LICENSE ./build/) ; \
	 (find ./src/main/sh/ -name '*.sh' -exec cp "{}" ./build/ \;) ; \
	 (chmod 755 ./build/make.sh) ; \
	 (cp ./src/main/resources/README.txt ./build/) ; \
	 (cp ./VERSION ./build/) ; \
	 (cp -r ./build/ ./dist/${VERSION}/) ; \
	 (cp -r ./dist/${VERSION}/ ./dist/latest/))
