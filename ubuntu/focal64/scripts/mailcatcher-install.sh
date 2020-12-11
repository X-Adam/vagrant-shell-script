#!/bin/bash

# Gerekli paketler kuruluyor.
apt install make build-essential sqlite3 libsqlite3-dev ruby-dev -y

# mailcatcher kuruluyor.
gem install mailcatcher

# mailcatcher başlatılıyor.
mailcatcher --ip=0.0.0.0

# Her açılıştan açılması için tanımlama yapılıyor.
echo "@reboot root $(which mailcatcher) --ip=0.0.0.0" >> /etc/crontab
update-rc.d cron defaults
