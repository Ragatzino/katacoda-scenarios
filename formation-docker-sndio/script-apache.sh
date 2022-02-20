#!/bin/bash
mkdir /root/apache
mkdir /root/apache/public-html
curl https://raw.githubusercontent.com/Ragatzino/katacoda-scenarios/main/formation-docker-sndio/assets-build-apache/public-html/index.html > /root/apache/public-html/index.html
curl https://raw.githubusercontent.com/Ragatzino/katacoda-scenarios/main/formation-docker-sndio/assets-build-apache/Dockerfile > /root/apache/Dockerfile