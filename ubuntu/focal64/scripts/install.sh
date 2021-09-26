#!/bin/bash
sudo su

SECONDS=0

# Paketler güncelleniyor.
apt update -y
apt upgrade -y

# Zaman dilimini ayarlanıyor
timedatectl set-timezone $TIMEZONE

# Temel paketler kuruluyor.
apt install curl -y
apt install git -y
apt install unzip -y
apt install composer -y

wget https://raw.githubusercontent.com/X-Adam/vagrant-shell-script/master/ubuntu/focal64/scripts/nginx-install.sh
bash nginx-install.sh
rm nginx-install.sh

wget https://raw.githubusercontent.com/X-Adam/vagrant-shell-script/master/ubuntu/focal64/scripts/php-install.sh
bash php-install.sh
rm php-install.sh

wget https://raw.githubusercontent.com/X-Adam/vagrant-shell-script/master/ubuntu/focal64/scripts/mysql-install.sh
bash mysql-install.sh
rm mysql-install.sh

wget https://raw.githubusercontent.com/X-Adam/vagrant-shell-script/master/ubuntu/focal64/scripts/phpmyadmin-install.sh
bash phpmyadmin-install.sh
rm phpmyadmin-install.sh

wget https://raw.githubusercontent.com/X-Adam/vagrant-shell-script/master/ubuntu/focal64/scripts/nodejs-install.sh
bash nodejs-install.sh
rm nodejs-install.sh

wget https://raw.githubusercontent.com/X-Adam/vagrant-shell-script/master/ubuntu/focal64/scripts/postfix-install.sh
bash postfix-install.sh
rm postfix-install.sh

wget https://raw.githubusercontent.com/X-Adam/vagrant-shell-script/master/ubuntu/focal64/scripts/mailcatcher-install.sh
bash mailcatcher-install.sh
rm mailcatcher-install.sh

wget https://raw.githubusercontent.com/X-Adam/vagrant-shell-script/master/ubuntu/focal64/scripts/supervisor-install.sh
bash supervisor-install.sh
rm supervisor-install.sh

echo 'The installation has been completed successfully.' "$(($SECONDS / 60)) minutes and $(($SECONDS % 60)) seconds elapsed."

echo "Don't forget to add the following entry to the hosts file:"
echo "127.0.0.1 $DOMAIN";
