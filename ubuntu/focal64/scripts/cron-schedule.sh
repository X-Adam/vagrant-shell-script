#!/bin/bash

cron="* * * * * www-data  . /home/vagrant/.profile; /usr/bin/php$PHP_VERSION /var/www/$DOMAIN/$DIR/artisan schedule:run >> /dev/null 2>&1"

echo "$cron" > "/etc/cron.d/$DOMAIN-$DIR"
