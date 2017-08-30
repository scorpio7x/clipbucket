apt-get update

apt-get install -y apache2 mariadb-server php5 php5-gd php5-mysql php5-curl php5-xsl php5-cli php-pear unzip

apt-get install -y imagemagick php5-imagick

php5enmod imagick

apt-add-repository ppa:mc3man/trusty-media

apt-get update

apt-get install -y ffmpeg gstreamer0.10-ffmpeg

apt-get install -y ruby

gem install flvtool2

apt-get install -y gpac mediainfo

wget https://github.com/scorpio7x/clipbucket/raw/master/php.ini

sudo mv -fv php.ini /etc/php5/apache2/php.ini

service apache2 restart

mysql_secure_installation

mysql -u root -p

	CREATE DATABASE clipbucketdb;
 	CREATE USER 'clipbucketuser'@'localhost' IDENTIFIED BY 'Pa$$worD';
 	GRANT ALL PRIVILEGES ON clipbucketdb.* TO 'clipbucketuser'@'localhost';
 	FLUSH PRIVILEGES;
 	EXIT;

wget https://github.com/scorpio7x/clipbucket/raw/master/clipbucket.conf	

sudo mv -fv clipbucket.conf /etc/apache2/sites-available/clipbucket.conf

ln -s /etc/apache2/sites-available/clipbucket.conf /etc/apache2/sites-enabled/clipbucket.conf

a2enmod rewrite

service apache2 restart

wget https://github.com/scorpio7x/clipbucket/raw/master/Clipbucket4829.zip

unzip Clipbucket4829.zip

mkdir /var/www/clipbucket

cp -rv clipbucket-4829/upload/* /var/www/clipbucket/

cp -v clipbucket-4829/upload/.htaccess /var/www/clipbucket/

chmod -R 777 /var/www/clipbucket/includes/
chmod -R 777 /var/www/clipbucket/files/
chmod -R 777 /var/www/clipbucket/images/
chmod -R 777 /var/www/clipbucket/cache/
chmod -R 777 /var/www/clipbucket/cb_install/

chown www-data:www-data -R /var/www/clipbucket/

crontab -e

	* * * * * php -q /var/www/clipbucket/actions/video_convert.php
	* * * * * php -q /var/www/clipbucket/actions/verify_converted_videos.php
	0 0,12,13 * * * php -q /var/www/clipbucket/actions/update_cb_stats.php
	
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables-save > /etc/iptables-up.rules

rm -frv clipbucket-4829
rm -frv Clipbucket4829.zip
rm -frv /var/www/clipbucket/cb_install/*







