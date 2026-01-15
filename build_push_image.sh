#!/bin/bash

# 1. Membuat Docker image dengan nama item-app dan tag v1
docker build -t item-app:v1 .

# 2. Menampilkan daftar image di lokal untuk verifikasi build
docker images

# 3. Mengubah nama image agar sesuai dengan format GitHub Packages (ghcr.io)
# Format: ghcr.io/USERNAME_GITHUB/NAMA_REPOSITORI/item-app:v1
docker tag item-app:v1 ghcr.io/ikbalbbm121/ikbalbbm120/item-app:v1

# 4. Login ke GitHub Container Registry via Terminal
# Anda akan diminta memasukkan GitHub Personal Access Token (PAT) sebagai password
echo "Login ke GitHub Packages..."
docker login ghcr.io -u ikbalbbm121

# 5. Mengunggah image ke GitHub Packages
docker push ghcr.io/ikbalbbm121/ikbalbbm120/item-app:v1
