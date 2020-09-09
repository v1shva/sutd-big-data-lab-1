#!/bin/bash
# =
mysqlRootPass=$1
mysqlDB=$2
# =
if [ $# -eq 0 ]; then
  echo "No arguments supplied"
else
  sudo apt-get update
  sudo apt-get install -y mysql-server
  echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$mysqlRootPass';
        UPDATE mysql.user SET Host='%' WHERE Host='localhost' AND User='root';
        UPDATE mysql.db SET Host='%' WHERE Host='localhost' AND User='root';
        FLUSH PRIVILEGES;" | sudo mysql -u root
  sudo cp my.cnf /etc/mysql/my.cnf
  sudo service mysql stop
  sudo service mysql start
  #ssh ubuntu@$mysqlIP -i ./key.pem sudo apt install -y mysql-client-5.7
  echo "create database $mysqlDB;" | mysql -u root -p$mysqlRootPass
fi
