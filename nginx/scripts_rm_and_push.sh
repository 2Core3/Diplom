#!/bin/bash

CONTAINER_ID=$(sudo docker ps -q)

if [ -n "$CONTAINER_ID" ]; then
    sudo docker rm -f $CONTAINER_ID
fi

sudo docker pull 1core2/nginx_main:latest
sudo docker run -d -p 80:80 1core2/nginx_main:latest