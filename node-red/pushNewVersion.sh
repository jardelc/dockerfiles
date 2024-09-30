#!/bin/bash

USERNAME="jardelc"
IMAGENAME="node-red"

# Read the version from the VERSION file
VERSION=$(cat VERSION)

# Build and tag the Docker image
docker build -t $USERNAME/$IMAGENAME:$VERSION .
docker tag $USERNAME/$IMAGENAME:$VERSION $USERNAME/$IMAGENAME:latest

# Push the tags to Docker Hub
docker push $USERNAME/$IMAGENAME:$VERSION
docker push $USERNAME/$IMAGENAME:latest