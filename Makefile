IMAGE_NAME      := thaim/sphinx

SPHINX_VERSION  := 2.1.2

## Dockerfile to build image
DOCKERFILE      := Dockerfile
## enable BuildKit option
DOCKER_BUILDKIT := 1


.PHONY: help build push save

help: ## このヘルプメッセージを表示
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

buildhub: ## DockerHubにてDockerイメージを生成する
	DOCKER_TAG=$(DOCKER_TAG) \
		DOCKERFILE_PATH=$(DOCKERFILE) \
		IMAGE_NAME=$(IMAGE_NAME):$(DOCKER_TAG) \
		sh hooks/build

build: ## Dockerイメージを生成する
	docker build \
		--progress=plain \
		--build-arg SPHINX_VERSION=${SPHINX_VERSION} \
		-t ${IMAGE_NAME}:latest \
		-t ${IMAGE_NAME}:${SPHINX_VERSION} \
		.

push: ## 生成したDockerイメージをRegistryに保存する
	docker push $(IMAGE):latest

save: ## 生成したDockerイメージをファイルに保存する
	docker save $(IMAGE) > $(GROUP)_$(NAME)_latest.tar

clean:
	docker builder prune -f
