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

wget https://raw.githubusercontent.com/X-Adam/vagrant-shell-script/master/ubuntu/focal64/scripts/nginx-install.sh
bash nginx-install.sh
rm nginx-install.sh
