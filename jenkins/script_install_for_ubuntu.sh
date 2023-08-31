#!/bin/bash

sudo apt update 

sudo apt install git -y

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y

sudo apt update

sudo apt install docker-ce -y

sudo systemctl enable docker

sudo systemctl start docker

sudo usermod -aG docker ubuntu

sudo apt  install awscli -y

git clone https://github.com/2Core3/Diplom.git

export AWS_CONFIG_FILE="/home/ubuntu/.aws/config"

export AWS_CLI_AUTO_PROMPT=on

aws_output=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=dos-13_Yudin-Anton_Jenkins" --query "Reservations[].Instances[].PublicIpAddress" --output text)

jenkins_url="JENKINS_URL=http://$aws_output:8080/"

echo "$jenkins_url" >> "/home/ubuntu/Diplom/jenkins/.env_example"

mv "/home/ubuntu/Diplom/jenkins/.env_example" "/home/ubuntu/Diplom/jenkins/.env"

mkdir /home/ubuntu/Diplom/jenkins/credantion

cp /home/ubuntu/credantion/* /home/ubuntu/Diplom/jenkins/credantion/

cd /home/ubuntu/Diplom/jenkins

sudo docker compose up -d