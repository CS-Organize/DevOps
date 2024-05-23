#!/bin/sh
# https://github.com/yobasystems/alpine-mariadb/blob/master/alpine-mariadb-aarch64/files/run.sh

if [ -d "/run/mysqld" ]; then
	chown -R mysql:mysql /run/mysqld
else
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
	chown -R mysql:mysql /var/lib/mysql
else
	chown -R mysql:mysql /var/lib/mysql

	mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

	tfile=`mktemp` # https://www.tutorialspoint.com/unix_commands/mktemp.htm
	if [ ! -f "$tfile" ]; then
		return 1
	fi

	cat << EOF > $tfile

USE mysql;
FLUSH PRIVILEGES ;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON wordpress.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;
GRANT ALL ON wordpress.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
CREATE DATABASE wordpress;
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
EOF

	/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < $tfile
	# rm -f $tfile
fi

exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 $@

# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE wordpress;"
# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON wordpress.* TO '$MYSQL_USER'@'localhost';"
# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON wordpress.* TO '$MYSQL_USER'@'%';"
# mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
