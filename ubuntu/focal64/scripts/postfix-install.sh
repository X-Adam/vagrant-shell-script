#!/bin/bash

# Kurulum ayarları tanımlanıyor.
debconf-set-selections <<< "postfix postfix/mailname string www.local.$DOMAIN"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"

apt install postfix -y
