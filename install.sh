#!/usr/bin/env bash

echo "--- Good morning, master. Let's get to work. Installing now. ---"

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- Installing base packages ---"
sudo apt-get install -y vim curl python-software-properties

echo "--- MySQL time ---"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- We want the bleeding edge of PHP, right master? ---"
sudo add-apt-repository -y ppa:ondrej/php5

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- Installing PHP-specific packages ---"
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt php5-mysql mysql-server git-core
echo "---setting up mysql access from host ---"
mysql --user=root --password=root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;"
sed -i "s/bind-address*/#bind-address/" /etc/mysql/my.cnf
sed -i "s/skip-external-locking*/#skip-external-locking/" /etc/mysql/my.cnf


echo "--- Restarting MySQL ---"
sudo service mysql restart

echo "--- Installing and configuring Xdebug ---"
sudo apt-get install -y php5-xdebug

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

echo "--- Enabling mod-rewrite ---"
sudo a2enmod rewrite

echo "--- What developer codes without errors turned on? Not you, master. ---"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini

sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

echo "--- Restarting Apache ---"
sudo service apache2 restart

echo "--- Composer is the future. But you knew that, did you master? Nice job. ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

#install codeception globally.. phpunit comes with it :-)
composer global require "codeception/codeception:*"
# add phpunit to path so it is available in command line
echo "PATH=\$PATH:~/.composer/vendor/bin" >> ~/.profile
#since we spend so much time in the terminal, why not make it a bit prettier?
echo "--- Installing Oh-My-Zsh ---"
# Install zsh
sudo apt-get install -y zsh

# Install oh-my-zsh
sudo su - vagrant -c 'wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh'

# Set default to the lovely "ys" theme.
sudo sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/' /home/vagrant/.zshrc
# Add /sbin to PATH.. And phpunit/codeception
sudo sed -i 's=:/bin:=:/bin:/sbin:/usr/sbin:~/.composer/vendor/bin:=' /home/vagrant/.zshrc
# Change vagrant user's default shell
chsh vagrant -s $(which zsh);

echo "--- All set to go! Would you like to play a game? ---"
