#!/bin/bash

# 1. Definisikan variabel secara terpisah agar lebih rapi
REGISTRY="ghcr.io"
USERNAME="ikbalbbm120"
IMAGE_NAME="karsajobs-ui"

# 2. Build Docker Image
# Tag akan menjadi ghcr.io/ikbalbbm120/karsajobs-ui:latest
echo "Building Docker image for Frontend..."
docker build -t $REGISTRY/$USERNAME/$IMAGE_NAME:latest .

# 3. Login ke GitHub Packages
# Kita harus menyebutkan alamat registry-nya (ghcr.io)
echo "Logging in to GitHub Packages..."
docker login $REGISTRY -u $USERNAME

# 4. Push Image ke GitHub Packages
echo "Pushing Frontend image to GitHub Packages..."
docker push $REGISTRY/$USERNAME/$IMAGE_NAME:latest

echo "Done! Frontend image has been pushed to GHCR."