#! /bin/bash

mysql_install_db --user=mysql --basedir=/usr/ --ldata=/var/lib/mysql/
chown -R mysql:mysql /var/lib/mysql
service mariadb start
mysql -uroot -psecret -e "CREATE USER 'root'@'127.0.0.1' IDENTIFIED BY 'secret';"
mysql -uroot -psecret -e "CREATE DATABASE IF NOT EXISTS langue;"
mysql -uroot -psecret -e "CREATE USER 'root'@'::1' IDENTIFIED BY 'secret';"
mysql -uroot -psecret -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1';"
mysql -uroot -psecret -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'::1';"
mysql -uroot -psecret -e "FLUSH PRIVILEGES;"
mysql langue < /var/lib/mysql/langue.sql
service mariadb stop

mariadbd --user=root

exec "$@"
