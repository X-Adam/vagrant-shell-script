#!/bin/bash

# Gerekli paketler kuruluyor.
apt install redis -y

systemctl enable redis-server
service redis-server start
