#!/bin/bash

apt install gnupg curl
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
apt update
apt install -y mongodb-org

echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-database hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-mongosh hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

systemctl start mongod
systemctl daemon-reload
systemctl enable mongod

# Varsayılan kullanıcı oluşturuluyor.
mongosh admin --eval "db.createUser({user:'dba',pwd:'secret',roles:['root']})";

# Configure MongoDB Remote Access
sed -i '/^  bindIp/s/bindIp:.*/bindIp: 0.0.0.0/' /etc/mongod.conf
systemctl restart mongod
