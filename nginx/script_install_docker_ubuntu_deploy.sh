#!/bin/bash

sudo apt update -y

sudo apt install docker.io prometheus-node-exporter -y

sudo systemctl start docker

sudo usermod -aG docker $USER

sudo docker pull 1core2/nginx_main:latest

sudo docker run -d -p 80:80 1core2/nginx_main:latest

