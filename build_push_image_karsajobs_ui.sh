#!/bin/bash

# 1. Definisikan variabel (ganti <username-docker> dengan username Anda)
USER_DOCKER="ikbalbbm120"
IMAGE_NAME="karsajobs-ui"

# 2. Build Docker Image
echo "Building Docker image for Backend..."
docker build -t $USER_DOCKER/$IMAGE_NAME:latest .

# 3. Login ke Docker Hub
# Anda akan diminta memasukkan password setelah menjalankan ini
echo "Logging in to Docker Hub..."
docker login -u $USER_DOCKER

# 4. Push Image ke Docker Hub
echo "Pushing Backend image to Docker Hub..."
docker push $USER_DOCKER/$IMAGE_NAME:latest

echo "Done! Backend image has been pushed."