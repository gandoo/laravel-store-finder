#!/bin/sh

# If you would like to do some extra provisioning you may
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.

# copy config
cp /vagrant/.env.firestead /vagrant/.env;

# start php dependencies
cd /vagrant/;
if [ ! -f composer.phar ];
	then
		sudo curl -sS https://getcomposer.org/installer | php;
	else
		php composer.phar self-update;
fi
php composer.phar install --no-ansi --no-interaction --no-progress --no-scripts --optimize-autoloader;

# start database
cd /vagrant/;
php artisan migrate;
php artisan db:seed;
