.PHONY: build run clean

DOCKER_IMAGE='jenkinsci/jenkinsio'
DOCKER_TAG=$(shell git rev-parse HEAD  | head -c 6)

build:
	@docker build -t '$(DOCKER_IMAGE):dev-$(DOCKER_TAG)' .

run:
	@cd .. && docker run -i -t --rm -v `pwd`/build/_site/:/usr/share/nginx/html -p 80:80 $(DOCKER_IMAGE):dev-$(DOCKER_TAG)

clean:
	docker rmi $(DOCKER_IMAGE):dev-$(DOCKER_TAG)
