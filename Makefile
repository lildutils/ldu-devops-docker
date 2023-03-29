.PHONY: clean
clean: clean-latest clean-version clean-snapshot clean-alpha clean-beta clean-build

.PHONY: build
build: compile build-others build-dist

.PHONY: watch
watch: watch-src

.PHONY: test
test: clean compile unit-tests

.PHONY: e2e
e2e: clean build e2e-tests

#######################################################################
## Tasks

### current version number
VERSION := $(shell cat VERSION)
### watcher in seconds
WATCHER := 2
### watcher mode: debug | silent
mode    := silent

.PHONY: clean-build
clean-build:
	(rm -rf ./build/)

.PHONY: clean-latest
clean-latest:
	(rm -rf ./dist/latest/)

.PHONY: clean-snapshot
clean-snapshot:
	(rm -rf ./dist/${VERSION}-SNAPSHOT/)

.PHONY: clean-alpha
clean-alpha:
	(rm -rf ./dist/${VERSION}a/)

.PHONY: clean-beta
clean-beta:
	(rm -rf ./dist/${VERSION}b/)

.PHONY: clean-version
clean-version:
	(rm -rf ./dist/${VERSION}/)

.PHONY: build-others
build-others:
	((cp ./LICENSE ./build/) && \
	 (cp ./src/main/resources/README.txt ./build/) && \
	 (cp ./VERSION ./build/))

.PHONY: build-dist
build-dist:
	((cp -r ./build/ ./dist/${VERSION}/) && \
	 (cp -r ./dist/${VERSION}/ ./dist/latest/))

.PHONY: compile
compile: compile-res compile-bin compile-make

.PHONY: compile-res
compile-res:
	((rm -rf ./build/resources/) && \
	 (mkdir -p ./build/resources/) && \
	 (find ./src/main/resources/ -name 'make.ini' -exec cp "{}" ./build/resources/make.ini \;) && \
	 (find ./src/main/resources/ -name 'docker-compose.env' -exec cp "{}" ./build/resources/docker-compose.env \;) && \
	 (find ./src/main/resources/ -name 'docker-compose.yml' -exec cp "{}" ./build/resources/docker-compose.yml \;))

.PHONY: compile-bin
compile-bin:
	((rm -rf ./build/tmp/bin/) && \
	 (mkdir -p ./build/tmp/bin/) && \
	 (find ./src/main/sh/app/commands/ -name '*.sh' -exec cp "{}" ./build/tmp/bin/ \;) && \
	 (find ./src/main/sh/app/tasks/ -name '*.sh' -exec cp "{}" ./build/tmp/bin/ \;) && \
	 (find ./src/main/sh/utils/ -name '*.sh' -exec cp "{}" ./build/tmp/bin/ \;) && \
	 (find ./src/main/sh/ -name 'main.pre.sh' -exec cp "{}" ./build/tmp/bin/ \;) && \
	 (find ./src/main/sh/ -name 'main.sh' -exec cp "{}" ./build/tmp/bin/ \;) && \
	 (find ./src/main/sh/ -name 'main.post.sh' -exec cp "{}" ./build/tmp/bin/ \;))

.PHONY: compile-make
compile-make:
	((cp ./lib/ldu-bash-compiler-1.0.0b.sh ./build/tmp/compiler.sh) && \
	 (chmod 755 ./build/tmp/compiler.sh) && \
	 (./build/tmp/compiler.sh "../make.sh") && \
	 (chmod 755 ./build/make.sh) && \
	 (rm -rf ./build/tmp/))

.PHONY: watch-src
watch-src:
	(if [ "${mode}" = "silent" ]; then \
		watch -n ${WATCHER} make compile --silent; \
	 else \
		watch -n ${WATCHER} make compile; \
	 fi)

.PHONY: unit-tests
unit-tests:
	((chmod -R 755 ./src/test/sh/unit/*.sh) && \
	 (/bin/bash ./src/test/sh/unit/run-all.sh ${test} ${args}))

.PHONY: unit-e2e
e2e-tests:
	((chmod -R 755 ./src/test/sh/integration/*.sh) && \
	 (/bin/bash ./src/test/sh/integration/run-all.sh ${test} ${args}))
