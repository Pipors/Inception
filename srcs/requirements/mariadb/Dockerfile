FROM			alpine:3.18

RUN				apk update && apk add --no-cache mariadb mariadb-client

RUN				mkdir -p /run/mysqld && chmod 777 /run/mysqld

RUN				sed -i "s|skip-networking|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
				
RUN				mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db

EXPOSE			3306

COPY			./conf/init-db.sh	init-db.sh

ENTRYPOINT		["sh", "/init-db.sh"]

CMD				["mariadbd", "--user=mysql", "--bind-address=0.0.0.0"]