SHELL := /bin/bash

.PHONY: envs push-envs mac-env windows-env centos-env debian-env arch-env generic-linux-env publish publish-beta

default: envs
	@true

envs: mac-env windows-env centos-env debian-env arch-env generic-linux-env

mac-env:
	if [[ ! $$(docker images nanobox/mac-env) =~ "nanobox/mac-env" ]]; then \
		docker build --no-cache -t nanobox/mac-env -f Dockerfile.mac-env .;\
	fi

windows-env:
	if [[ ! $$(docker images nanobox/windows-env) =~ "nanobox/windows-env" ]]; then \
		docker build --no-cache -t nanobox/windows-env -f Dockerfile.windows-env .; \
	fi

centos-env:
	if [[ ! $$(docker images nanobox/centos-env) =~ "nanobox/centos-env" ]]; then \
		docker build --no-cache -t nanobox/centos-env -f Dockerfile.centos-env .; \
	fi

debian-env:
	if [[ ! $$(docker images nanobox/debian-env) =~ "nanobox/debian-env" ]]; then \
		docker build --no-cache -t nanobox/debian-env -f Dockerfile.debian-env .; \
	fi

arch-env:
	if [[ ! $$(docker images nanobox/arch-env) =~ "nanobox/arch-env" ]]; then \
		docker build --no-cache -t nanobox/arch-env -f Dockerfile.arch-env .; \
	fi

generic-linux-env:
	if [[ ! $$(docker images nanobox/generic-linux-env) =~ "nanobox/generic-linux-env" ]]; then \
		docker build --no-cache -t nanobox/generic-linux-env -f Dockerfile.generic-linux-env .; \
	fi

publish:
	docker push nanobox/generic-linux-env
	docker push nanobox/arch-env
	docker push nanobox/debian-env
	docker push nanobox/centos-env
	docker push nanobox/windows-env
	docker push nanobox/mac-env

publish-beta:
	docker tag nanobox/generic-linux-env nanobox/generic-linux-env-beta
	docker tag nanobox/arch-env nanobox/arch-env-beta
	docker tag nanobox/debian-env nanobox/debian-env-beta
	docker tag nanobox/centos-env nanobox/centos-env-beta
	docker tag nanobox/windows-env nanobox/windows-env-beta
	docker tag nanobox/mac-env nanobox/mac-env-beta
	docker push nanobox/generic-linux-env-beta
	docker push nanobox/arch-env-beta
	docker push nanobox/debian-env-beta
	docker push nanobox/centos-env-beta
	docker push nanobox/windows-env-beta
	docker push nanobox/mac-env-beta
