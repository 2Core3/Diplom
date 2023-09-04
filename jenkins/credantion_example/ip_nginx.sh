#!/bin/bash

ip_nginx=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=dos-13_Yudin-Anton_nginx" --query "Reservations[].Instances[].PublicIpAddress" --output text)

output_file="ip_server_nginx"

echo "$ip_nginx" > "$output_file"