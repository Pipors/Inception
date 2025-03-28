#!/bin/bash

# Check if WordPress is already installed
if [ -f "/var/www/html/wordpress/wp-config.php" ]; then
    echo "WordPress is already installed in this directory."
    exec "$@"
fi

# Download WP-CLI 
# Make WP-CLI executable
# Move WP-CLI to a directory in the system's PATH
if [ ! -d "/usr/local/bin/wp" ]; then
    cd /tmp
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

if [ ! -d "/var/www/html/wordpress" ]; then
    mkdir -p /var/www/html/wordpress
fi
cd /var/www/html/wordpress

chmod -R 755 /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress

wp core download --allow-root
echo "Generating WordPress 'wp-config.php'..."
#wp config create --allow-root --dbname=${WP_DB_NAME} --dbuser=${WP_USER} --dbpass=${WP_PASSWD} --dbhost=${WP_HOST}
sed -i -r "s/database_name_here/$WP_DB_NAME/1" wp-config-sample.php
sed -i -r "s/username_here/$DB_USER/1" wp-config-sample.php
sed -i -r "s/password_here/$DB_PASSWD/1" wp-config-sample.php
sed -i -r "s/localhost/mariadb:3306/1" wp-config-sample.php

cat wp-config-sample.php >> wp-config.php

sleep 10

echo "\033[93m Installing WordPress deps... \033[0m" 
wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWD} --admin_email=${WP_ADMIN_EMAIL} --allow-root

echo "Creating users..."
wp user create ${WP_ADMIN} ${WP_ADMIN_EMAIL} --role=administrator --user_pass=${WP_ADMIN_PASSWD} --path=/var/www/html/wordpress --allow-root

wp user create ${WP_USER} ${WP_USER_EMAIL} --role=editor --user_pass=${WP_PASSWD} --path=/var/www/html/wordpress --allow-root 

chmod -R 755 /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress
exec "$@"