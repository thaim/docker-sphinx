# syntax = docker/dockerfile:experimental
FROM python:3.7.4-buster

ARG SPHINX_VERSION

RUN --mount=type=cache,target=/var/lib/apt \
    --mount=type=cache,target=/var/chache/apt \
    apt-get update \
 && apt-get install -y --no-install-recommends \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-lang-cjk \
    texlive-lang-japanese \
    latexmk \
    graphviz \
 && mkdir /documents
#    texlive-fonts-extra
#    texlive-formats-extra \
#    texlive-lang-cjk \

WORKDIR /documents

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install sphinx==${SPHINX_VERSION}
