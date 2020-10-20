#!/bin/bash
sudo echo "127.0.0.1 `hostname`" >> /etc/hosts
sudo apt-get update -y
sudo apt-get install mysql-client -y
sudo apt-get install apache2 apache2-utils -y
sudo apt-get install php5 -y
sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-gd php5-xmlrp -y
sudo apt-get install php5-mysqlnd-ms -y
sudo apt-get install php-gd php-mysql libapache2-mod-php -y
sudo service apache2 restart
sudo echo "[mysql]" > /home/ubuntu/.my.cnf
sudo echo "host = localhost" >> /home/ubuntu/.my.cnf
sudo echo "port = 3306" >> /home/ubuntu/.my.cnf
sudo echo "user = username_here" >> /home/ubuntu/.my.cnf
sudo echo "password = password_here" >> /home/ubuntu/.my.cnf
sudo sed -i 's/localhost/${db_hostname}/g' /home/ubuntu/.my.cnf
sudo sed -i 's/username_here/${db_user}/g' /home/ubuntu/.my.cnf
sudo sed -i 's/password_here/${db_password}/g' /home/ubuntu/.my.cnf
sudo chown ubuntu.ubuntu /home/ubuntu/.my.cnf
sudo chmod 600 ~/.my.cnf
sudo mkdir /home/ubuntu/git
sudo git clone https://github.com/mwpreston/tf-ec2-rds-mabel.git /home/ubuntu/git
mysql {$db_name} < /home/ubuntu/git/files/mabel.sql
sudo mkdir -p /var/www/html/
sudo tar -xzvf /home/ubuntu/git/files/wordpress.tar.gz -C /var/www/html/
sudo sed -i 's/localhost/${db_hostname}/g' /var/www/html/wp-config.php
sudo sed -i 's/database_name_here/${db_name}/g' /var/www/html/wp-config.php
sudo sed -i 's/username_here/${db_user}/g' /var/www/html/wp-config.php
sudo sed -i 's/password_here/${db_password}/g' /var/www/html/wp-config.php
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
sudo service apache2 restart