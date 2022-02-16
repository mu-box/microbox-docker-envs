SHELL := /bin/bash
tag?=latest

.PHONY: envs mac-env windows-env arch-env centos-env debian-env generic-linux-env publish publish-beta

default: envs
	@true

envs: mac-env windows-env arch-env centos-env debian-env generic-linux-env

mac-env:
	if [[ ! $$(docker images mubox/mac-env) =~ "mubox/mac-env" ]]; then \
		docker build --no-cache -t mubox/mac-env -f Dockerfile.mac-env .;\
	fi

windows-env:
	if [[ ! $$(docker images mubox/windows-env) =~ "mubox/windows-env" ]]; then \
		docker build --no-cache -t mubox/windows-env -f Dockerfile.windows-env .; \
	fi

arch-env:
	if [[ ! $$(docker images mubox/arch-env) =~ "mubox/arch-env" ]]; then \
		docker build --no-cache -t mubox/arch-env -f Dockerfile.arch-env .; \
	fi

centos-env:
	if [[ ! $$(docker images mubox/centos-env) =~ "mubox/centos-env" ]]; then \
		docker build --no-cache -t mubox/centos-env -f Dockerfile.centos-env .; \
	fi

debian-env:
	if [[ ! $$(docker images mubox/debian-env) =~ "mubox/debian-env" ]]; then \
		docker build --no-cache -t mubox/debian-env -f Dockerfile.debian-env .; \
	fi

generic-linux-env:
	if [[ ! $$(docker images mubox/generic-linux-env) =~ "mubox/generic-linux-env" ]]; then \
		docker build --no-cache -t mubox/generic-linux-env -f Dockerfile.generic-linux-env .; \
	fi

publish: publish-mac publish-windows publish-arch publish-centos publish-debian publish-generic-linux

publish-mac:
	if [ "$(tag)" != "latest" ]; then \
		docker tag mubox/mac-env mubox/mac-env:$(tag); \
	fi
	docker push mubox/mac-env:$(tag)

publish-windows:
	if [ "$(tag)" != "latest" ]; then \
		docker tag mubox/windows-env mubox/windows-env:$(tag); \
	fi
	docker push mubox/windows-env:$(tag)

publish-arch:
	if [ "$(tag)" != "latest" ]; then \
		docker tag mubox/arch-env mubox/arch-env:$(tag); \
	fi
	docker push mubox/arch-env:$(tag)

publish-centos:
	if [ "$(tag)" != "latest" ]; then \
		docker tag mubox/centos-env mubox/centos-env:$(tag); \
	fi
	docker push mubox/centos-env:$(tag)

publish-debian:
	if [ "$(tag)" != "latest" ]; then \
		docker tag mubox/debian-env mubox/debian-env:$(tag); \
	fi
	docker push mubox/debian-env:$(tag)

publish-generic-linux:
	if [ "$(tag)" != "latest" ]; then \
		docker tag mubox/generic-linux-env mubox/generic-linux-env:$(tag); \
	fi
	docker push mubox/generic-linux-env:$(tag)

publish-beta: publish-mac-beta publish-windows-beta publish-arch-beta publish-centos-beta publish-debian-beta publish-generic-linux-beta

publish-mac-beta:
	docker tag mubox/mac-env mubox/mac-env:beta
	docker push mubox/mac-env:beta

publish-windows-beta:
	docker tag mubox/windows-env mubox/windows-env:beta
	docker push mubox/windows-env:beta

publish-arch-beta:
	docker tag mubox/arch-env mubox/arch-env:beta
	docker push mubox/arch-env:beta

publish-centos-beta:
	docker tag mubox/centos-env mubox/centos-env:beta
	docker push mubox/centos-env:beta

publish-debian-beta:
	docker tag mubox/debian-env mubox/debian-env:beta
	docker push mubox/debian-env:beta

publish-generic-linux-beta:
	docker tag mubox/generic-linux-env mubox/generic-linux-env:beta
	docker push mubox/generic-linux-env:beta
