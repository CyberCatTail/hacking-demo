#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

IMAGE_NAME="vuljndi-app"
CONTAINER_NAME="vuljndi-app"

if ! docker ps -a --filter "name=$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
  echo "Container $CONTAINER_NAME does not exist. Creating and starting the container..."
  docker run -d -p 8080:8080 --name "$CONTAINER_NAME" "$IMAGE_NAME"
else
  CONTAINER_STATUS=$(docker inspect -f '{{.State.Status}}' "$CONTAINER_NAME")

  if [ "$CONTAINER_STATUS" == "paused" ]; then
    # Container is paused, unpause it
    echo "Container $CONTAINER_NAME is paused. Unpausing it..."
    docker unpause "$CONTAINER_NAME"
  elif [ "$CONTAINER_STATUS" == "exited" ]; then
    # Container is stopped, start it
    echo "Container $CONTAINER_NAME is stopped. Starting it..."
    docker start "$CONTAINER_NAME"
  else
    # Container is already running
    echo "Container $CONTAINER_NAME is already running. No action needed."
  fi
fi