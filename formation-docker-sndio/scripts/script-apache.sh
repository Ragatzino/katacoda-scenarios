#!/bin/bash
mkdir apache
mkdir apache/public-html
curl https://raw.githubusercontent.com/Ragatzino/katacoda-scenarios/main/formation-docker-sndio/assets-build-apache/public-html/index.html > apache/public-html/index.html
curl https://raw.githubusercontent.com/Ragatzino/katacoda-scenarios/main/formation-docker-sndio/assets-build-apache/Dockerfile > apache/Dockerfile