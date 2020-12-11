#!/bin/bash

apt install nginx -y

sed -i "/sites-enabled/a \        include /var/www/*/*/nginx.conf;" /etc/nginx/nginx.conf    # Nginx yapılandırma dosyası yedekleniyor, yapılandırmalar uygulanıyor.

# Proje dizini oluşturuluyor, klasör sahibi değiştiriliyor, paylaşılan klasör kısayol olarak ekleniyor.
mkdir /var/www/$DOMAIN
chown ubuntu:ubuntu /var/www/$DOMAIN
ln -s /vagrant /var/www/$DOMAIN/Api

if [ ! -f /vagrant/nginx.conf ]; then
  wget https://raw.githubusercontent.com/X-Adam/vagrant-shell-script/master/ubuntu/focal64/nginx.conf.example --output-document=/vagrant/nginx.conf
  sed -i "s/example-domain.com/$DOMAIN/g" /vagrant/nginx.conf
fi
