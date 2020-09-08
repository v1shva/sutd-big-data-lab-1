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
  # [ ! -e /usr/bin/expect ] && { sudo apt-get -y install expect; }
  # SECURE_MYSQL=$(expect -c "

  #   set timeout 10
  #   spawn sudo mysql_secure_installation

  #   expect \"Enter current password for root (enter for none): \"
  #   send \"n\r\"
  #   expect \"Switch to unix_socket authentication \[Y/n\] \"
  #   send \"n\r\"
  #   expect \"Change the root password? \[Y/n\] \"
  #   send \"y\r\"
  #   expect \"New password: \"
  #   send \"$mysqlRootPass \r\"
  #   expect \"Re-enter new password: \"
  #   send \"$mysqlRootPass \r\"
  #   expect \"Remove anonymous users? \[Y/n\] \"
  #   send \"y\r\"
  #   expect \"Disallow root login remotely? \[Y/n\] \"
  #   send \"n\r\"
  #   expect \"Remove test database and access to it? \[Y/n\] \"
  #   send \"y\r\"
  #   expect \"Reload privilege tables now? \[Y/n\] \"
  #   send \"y\r\"
  #   expect eof
  #   ")
  echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$mysqlRootPass';
        UPDATE mysql.user SET Host='%' WHERE Host='localhost' AND User='root';
        UPDATE mysql.db SET Host='%' WHERE Host='localhost' AND User='root';
        FLUSH PRIVILEGES;" | sudo mysql -u root
  sudo cp my.cnf /etc/mysql/my.cnf
  sudo service mysql stop
  sudo service mysql start
  #ssh ubuntu@$mysqlIP -i ./key.pem sudo apt install -y mysql-client-5.7
  echo "create database $mysqlDB;  
        use $mysqlDB; 
        create table if not exists reviews (
          id INT AUTO_INCREMENT PRIMARY KEY,
          reviewerID VARCHAR(255) NOT NULL,
          asin VARCHAR(255) NOT NULL,
          reviewerName VARCHAR(255) NOT NULL,
          helpful VARCHAR(255),
          reviewText TEXT NOT NULL,
          overall FLOAT NOT NULL,
          summary TEXT NOT NULL,
          unixReviewTime INT NOT NULL,
          reviewTime VARCHAR(255) NOT NULL,
          INDEX (asin),
          INDEX (reviewerID)
        );" | mysql -u root -p$mysqlRootPass
fi
