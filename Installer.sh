#!/bin/bash -e
clear
echo "======================================================================================================"
echo -e "WordPress Install Script"
echo "Script By Ashkan Ebrahimi"
echo "Script For Control Panel DirectAdmin"
echo "Git: AshkanSecure | GitHub: AshkanSecure | Instagram: Secure_Manager | Email: ashkan.secure@gmail.com|"
echo "======================================================================================================="
read -p '1) Please Enter DataBase Name:' dbname; echo  " You'r DataBase Name Has $dbname "
read -p '2) Please Enter DataBase User: ' dbuser; echo " You'r DataBase User Has $dbuser "
read -p '3) Please Enter Password DataBase: ' dbpass ' echo " You'r DataBase Password $dbpass "
read -p '4) Please Insert HostName: ' hostname ; echo " You'r Host Name Has $hostname "
echo "run install? (y/n)"
read -e run
if [ "$run" == n ] ; then
exit
else
echo "============================================"
echo "A robot is now installing WordPress for you."
echo "============================================"
#download wordpress
wget https://wordpress.org/latest.tar.gz -p /home/$hostname/public_html/
#move to Directory Hostname
cd /home/$hostname/public_html
#unzip wordpress
tar -zxvf latest.tar.gz
#change dir to wordpress
cd wordpress
#copy file to parent dir
cp -rf . ..
#move back to parent dir
cd ..
#remove files from wordpress folder
rm -R wordpress
#Remove xmlrpc.ph
rm -f xmlrpc.php
#Remove license.txt
rm -f license.txt
#Remove readme.html
rm -f readme.html
#create wp config
cp wp-config-sample.php wp-config.php
#set database details with perl find and replace
perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
perl -pi -e "s/username_here/$dbuser/g" wp-config.php
perl -pi -e "s/password_here/$dbpass/g" wp-config.php

#set WP salts
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php

#create uploads folder and set permissions
mkdir wp-content/uploads
chmod 775 wp-content/uploads
echo "Cleaning..."
#remove zip file
rm latest.tar.gz
#Import Hostname
chown $host_name:$hostname -R /home/$host_name/public_html/
#
echo "========================="
echo "Installation is complete."
echo "========================="
fi
echo "======================================================================================================"
echo "WordPress Install Script"
echo "Script By Ashkan Ebrahimi"
echo "Script For Control Panel DirectAdmin"
echo "Git: AshkanSecure | GitHub: AshkanSecure | Instagram: Secure_Manager | Email: ashkan.secure@gmail.com|"
echo "======================================================================================================="

