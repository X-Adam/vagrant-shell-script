#!/bin/bash

# Kurulum ayarları tanımlanıyor.
debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/internal/skip-preseed boolean false'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password '$DB_PASSWORD
debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password '$DB_PASSWORD
debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password '$DB_PASSWORD

apt-get install phpmyadmin -y

cat > /etc/nginx/snippets/phpmyadmin.conf << EOF
location /phpmyadmin {
    root /usr/share/;
    index index.html index.htm index.php;

    location ~ ^/phpmyadmin/(.+\.php)$ {
        try_files \$uri =404;
        root /usr/share/;
        fastcgi_pass unix:/run/php/php7.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include /etc/nginx/fastcgi_params;
    }

    location ~* ^/phpmyadmin/(.+\.(jpg|jpeg|gif|css|png|js|ico|html|xml|txt))$ {
        root /usr/share/;
    }
}

EOF

wget --output-document=phpMyAdmin.zip https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip    # phpMyAdmin'in son sürümü indiriliyor.
unzip phpMyAdmin.zip -d phpMyAdmin    # İndirilen zip dosyası açılıyor.
rm -rf /usr/share/phpmyadmin/*    # Paket yöneticisinden kurulan phpMyAdmin dosyaları siliyor.
cp -r phpMyAdmin/*/* /usr/share/phpmyadmin/    # İndirilen phpMyAdmin dosyaları kopyalanıyor.
rm -rf phpMyAdmin phpMyAdmin.zip    # İndirilen dosyalar siliyor.

mkdir /usr/share/phpmyadmin/tmp/    # phpMyAdmin temp dizini oluşturuluyor.
sudo chown -R www-data:www-data /usr/share/phpmyadmin/tmp/    # Yetkiler veriliyor.

cat > /usr/share/phpmyadmin/config.inc.php << EOF
<?php

declare(strict_types=1);

\$cfg['blowfish_secret'] = '$(cat /dev/urandom | tr -dc "a-zA-Z0-9" | fold -w 32 | head -n 1)';

EOF
