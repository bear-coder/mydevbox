#!/usr/bin/env bash

SERVERNAME=${1}
SERVERALIAS=${2}
DOCROOT=${3}


sudo mkdir "${DOCROOT}"

# setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    ServerName  "${SERVERNAME}"
    DocumentRoot "${DOCROOT}"
    <Directory "${DOCROOT}">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# enable mod_rewrite
sudo a2enmod rewrite

# restart apache
service apache2 restart