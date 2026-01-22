#!/bin/bash

# 1. Definisi Variabel
USER_DOCKER="ikbalbbm120"
IMAGE_NAME="karsajobs-ui"

# 2. Build Docker Image
docker build -t $USER_DOCKER/$IMAGE_NAME:latest .

# 3. Login ke Docker Hub
docker login -u $USER_DOCKER

# 4. Push Image ke Docker Hub
docker push $USER_DOCKER/$IMAGE_NAME:latest