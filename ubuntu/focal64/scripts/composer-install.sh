#!/bin/bash

apt install composer -y

if [[ $1 = "8.0" ]] || [[ $1 = "8.1" ]]
then
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php composer-setup.php
  php -r "unlink('composer-setup.php');"

  sudo mv composer.phar /usr/bin/composer
fi
