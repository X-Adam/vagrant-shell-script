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

mysql -e "CREATE DATABASE `system` CHARACTER SET `utf8mb4` COLLATE `utf8mb4_unicode_ci`;"    # System veritabanı oluşturuluyor.

sed -i 's/= 127.0.0.1/= 0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf    # Uzaktan erişim ayarlanıyor.
mysql -e "CREATE USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '$DB_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$DB_PASSWORD';"

sudo systemctl restart mysql
