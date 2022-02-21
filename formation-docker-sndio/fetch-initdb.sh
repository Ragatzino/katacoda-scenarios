#!/bin/bash
mkdir /root/postgres
curl https://raw.githubusercontent.com/Ragatzino/katacoda-scenarios/main/formation-docker-sndio/assets-postgres/init.sql > /root/postgres/initdb.sql
