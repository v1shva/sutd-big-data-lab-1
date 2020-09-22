#!/bin/bash
# =
mysqlUsername=${1:-root}
mysqlPass=${2:-24tz3wgF7vpJhkYG}
mysqlDB=${3:-istdbigdata}
# =
if [ $# -eq 0 ]; then
  echo "No arguments supplied"
else
  sudo apt-get update
  sudo apt-get install -y mysql-server
echo "CREATE USER '$mysqlUsername'@'%' IDENTIFIED BY ""' '$mysqlPass';
      GRANT ALL PRIVILEGES ON *.* to '$mysqlUsername'@'%'
      FLUSH PRIVILEGES;
      CREATE DATABASE IF NOT EXISTS '$mysqlDB';" | sudo mysql -u root
sudo cp my.cnf /etc/mysql/my.cnf
sudo service mysql stop
sudo service mysql start