#!/bin/bash
sudo apt update
sudo apt install prometheus-node-exporter awscli -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
sudo apt update
sudo apt install docker-ce -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu

api_file="/home/ubuntu/credantion/telegram_api"
id_file="/home/ubuntu/credantion/telegram_id"
config_file="/home/ubuntu/monitoring/alertmanager/config.yml"

api_value=$(cat "$api_file")
id_value=$(cat "$id_file")

sed -i "s/bot_token: api/bot_token: $api_value/g" "$config_file"
sed -i "s/chat_id: id/chat_id: $id_value/g" "$config_file"

export AWS_CONFIG_FILE="/home/ubuntu/.aws/config"
export AWS_CLI_AUTO_PROMPT=on

aws_jenkins=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=dos-13_Yudin-Anton_Jenkins" --query "Reservations[].Instances[].PublicIpAddress" --output text)
aws_nginx=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=dos-13_Yudin-Anton_Nginx" --query "Reservations[].Instances[].PublicIpAddress" --output text)
aws_monitoring=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=dos-13_Yudin-Anton_Monitoring" --query "Reservations[].Instances[].PublicIpAddress" --output text)

prometheus_config="/home/ubuntu/monitoring/prometheus/prometheus.yml"

sed -i "s/aws_jenkins/$aws_jenkins/g" "$prometheus_config"
sed -i "s/aws_nginx/$aws_nginx/g" "$prometheus_config"
sed -i "s/aws_monitoring/$aws_monitoring/g" "$prometheus_config"

cd /home/ubuntu/monitoring

sudo docker compose up -d