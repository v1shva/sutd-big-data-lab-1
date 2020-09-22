#!/bin/bash
# =
mysqlUsername=$1
mysqlPass=$2
mysqlDB=$3
# =
if [ $# -eq 0 ]; then
  echo "No arguments supplied"
else
  sudo apt-get update
  sudo apt-get install -y mysql-server
echo "CREATE USER '$mysqlUsername'@'%' IDENTIFIED BY ""' '$mysqlPass';
      GRANT ALL PRIVILEGES ON *.* to '$mysqlUsername'@'%'
      FLUSH PRIVILEGES;" | sudo mysql -u root
sudo cp my.cnf /etc/mysql/my.cnf
sudo service mysql stop
sudo service mysql start