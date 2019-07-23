# docker-sphinx
docker image for sphinx

## how to build sphinx documents

run as follow:

```
$ docker run -it \
    -u $(id -u):$(id -g) \
    -v $(pwd)/sampledocs:/documents \
    thaim/sphinx

```

## how to build docker image

```
$ make build
```
