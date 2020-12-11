#!/bin/bash
sudo su

# Paketler güncelleniyor.
apt update -y
apt upgrade -y

# Temel paketler kuruluyor.
apt install curl -y
apt install git -y
apt install unzip -y
apt install composer -y