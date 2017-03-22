#!/bin/bash

#update the instance

yum update -y 

#install apache server, php, php mysql and stress app
yum install httpd php php-mysql stress -y


cd /etc/httpd/conf

cp httpd.conf httpdconfbackup.conf

rm -rf httpd.conf

wget https://s3-eu-west-1.amazonaws.com/acloudguru-wp/httpd.conf


# create a .healthy.html file for the loadbalancer healthcheck
cd /var/www/html
echo "healthy" > healthy.html


#get wordpress
wget https://wordpress.org/latest.tar.gz


tar -xzf latest.tar.gz

cp -r wordpress/* /var/www/html/

rm -rf wordpress

rm -rf latest.tar.gz

chmod -R 755 wp-content

chown -R apache.apache wp-content


#start the apache server
service httpd start


#start apache webserver at each restart of instance
chkconfig httpd on