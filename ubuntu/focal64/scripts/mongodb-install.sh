#!/bin/bash

curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt update
sudo apt install mongodb-org -y
sudo systemctl start mongod.service
sudo systemctl enable mongod

# Varsayılan kullanıcı oluşturuluyor.
mongo --eval 'db.createUser({
	user: "dba",
	pwd: "secret",
	roles: [{role: "userAdminAnyDatabase", db: "admin"}]
});'

# Configure MongoDB Remote Access
sed -i '/^  bindIp/s/bindIp:.*/bindIp: 0.0.0.0/' /etc/mongod.conf
systemctl restart mongod
