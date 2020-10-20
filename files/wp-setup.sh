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
sudo wget -c http://wordpress.org/wordpress-5.1.1.tar.gz
sudo tar -xzvf wordpress-5.1.1.tar.gz
sleep 20
sudo mkdir -p /var/www/html/
sudo rsync -av wordpress/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo service apache2 restart
echo "${db_hostname}" >> /home/ubuntu/sedcmd
sudo sed -i 's/localhost/${db_hostname}/g' /var/www/html/wp-config.php >> /home/ubuntu/sedcmd
sudo sed -i 's/database_name_here/${db_name}/g' /var/www/html/wp-config.php >> /home/ubuntu/sedcmd
sudo sed -i 's/username_here/${db_user}/g' /var/www/html/wp-config.php >> /home/ubuntu/sedcmd
sudo sed -i 's/password_here/${db_password}/g' /var/www/html/wp-config.php >> /home/ubuntu/sedcmd
sudo rm -fr /var/www/html/index.html
cat <<EOT >> ~/.my.cnf
[mysqldump]
host = ${db_hostname}
port = 3306
user = ${db_user}
password = ${db_password}

[mysql]
host = ${db_hostname}
port = 3306
user = ${db_user}
password = ${db_password}
EOT
chmod 600 ~/.my.cnf
mkdir /home/ubuntu/git
git clone git clone https://github.com/mwpreston/tf-ec2-rds-mabel.git /home/ubuntu/git
mysql {$db_name}


