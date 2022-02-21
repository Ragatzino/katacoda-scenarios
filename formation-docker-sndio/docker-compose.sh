#!/bin/bash
# Kill all containers
containers=$(docker ps -q)
if [ ! -z $containers ]; then
  docker kill $containers;
fi
