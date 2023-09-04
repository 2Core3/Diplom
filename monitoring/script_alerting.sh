#!/bin/bash


api_file="/home/ubuntu/credantion/telegram_api"


id_file="/home/ubuntu/credantion/telegram_id"


config_file="/home/ubuntu/monitoring/alertmanager/config.yml"

api_value=$(cat "$api_file")
id_value=$(cat "$id_file")

sed -i "s/bot_token: api/api: $api_value/g" "$config_file"
sed -i "s/chat_id: id/chat_id: $id_value/g" "$config_file"