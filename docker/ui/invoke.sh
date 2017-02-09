#!/bin/bash

if [ -f /opt/sfm-setup/server.crt ]; then
    echo "Copying SSL certificate"
    cp /opt/sfm-setup/server.crt /etc/ssl/certs/server.crt
    cp /opt/sfm-setup/server.key /etc/ssl/private/server.key
    chown root:ssl-cert /etc/ssl/private/server.key
    chmod 0640 /etc/ssl/private/server.key
    echo "Adding sfm user to ssl-cert group"
    usermod -a -G ssl-cert sfm
fi

echo "Running server"
export SFM_RUN_SCHEDULER=True
# source /etc/apache2/envvars
# old, incompletely-shutdown httpd makes the apache start incorrectly
rm -rf /run/apache2/* /tmp/httpd*
echo "start apache on foreground"
apachectl -DFOREGROUND
