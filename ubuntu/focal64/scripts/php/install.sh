#!/bin/bash

wget https://raw.githubusercontent.com/X-Adam/vagrant-shell-script/master/ubuntu/focal64/scripts/php/$PHP_VERSION-install.sh
bash $PHP_VERSION-install.sh
rm $PHP_VERSION-install.sh
