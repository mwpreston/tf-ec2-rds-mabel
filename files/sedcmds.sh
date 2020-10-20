#!/bin/bash
sudo sed -i 's/database_name_here/'"${db_name}"'/g' /var/www/html/wp-config.php
sudo sed -i 's/username_here/'"${db_user}"'/g' /var/www/html/wp-config.php
sudo sed -i 's/password_here/'"${db_password}"'/g' /var/www/html/wp-config.php
sudo sed -i 's/localhost/${db_hostname}/g' /var/www/html/wp-config.php