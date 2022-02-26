#!/bin/bash

apt install mysql-server -y

# Expect paketi kuruluyor.
apt install expect -y

# Expect scripti kuruluyor.
tee ~/mysql-install.sh > /dev/null << EOF
spawn $(which mysql_secure_installation)

expect "Press y|Y for Yes, any other key for No:"
send "n\r"

expect "New password:"
send "$DB_PASSWORD\r"

expect "Re-enter new password:"
send "$DB_PASSWORD\r"

expect "Remove anonymous users? (Press y|Y for Yes, any other key for No) :"
send "y\r"

expect "Disallow root login remotely? (Press y|Y for Yes, any other key for No) :"
send "y\r"

expect "Remove test database and access to it? (Press y|Y for Yes, any other key for No) :"
send "y\r"

expect "Reload privilege tables now? (Press y|Y for Yes, any other key for No) :"
send "y\r"
EOF

# Script çalıştırılıyor.
sudo expect ~/mysql-install.sh

rm -v ~/mysql-install.sh    # Script dosyası güvenlik amacıyla siliniyor.
#sudo apt -qq purge expect > /dev/null    # Expect'i kaldırın, Expect'e ihtiyacınız olması durumunda yorum yapın.

mysql --user="root" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
mysql --user="root" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;"
mysql --user="root" -e "CREATE USER 'dba'@'0.0.0.0' IDENTIFIED BY '$DB_PASSWORD';"
mysql --user="root" -e "CREATE USER 'dba'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql --user="root" -e "GRANT ALL PRIVILEGES ON *.* TO 'dba'@'0.0.0.0' WITH GRANT OPTION;"
mysql --user="root" -e "GRANT ALL PRIVILEGES ON *.* TO 'dba'@'%' WITH GRANT OPTION;"
mysql --user="root" -e "FLUSH PRIVILEGES;"
mysql --user="root" -e 'CREATE DATABASE `system` CHARACTER SET `utf8mb4` COLLATE `utf8mb4_unicode_ci`;'

# Configure MySQL Remote Access
sed -i '/^bind-address/s/bind-address.*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
service mysql restart
