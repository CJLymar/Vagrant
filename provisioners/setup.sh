# Update installed packages
echo 'Updating Installed Packages'
yum -y update
yum -y upgrade

# Add third party repositories (EPEL & Community Enterprise Linux Repository) & Utilities
echo 'Adding 3rd Party Repositories'
yum -y install epel-release
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# Install additional packages
echo 'Installing Additional Packages'
yum -y install nano nmap wget telnet p7zip ntp htop npm nodejs

# Install Nginx
echo 'Installing & Configuring Nginx'
yum -y install nginx
systemctl enable nginx
systemctl start nginx
mkdir /etc/nginx/sites
rmdir /etc/nginx/default.d
cp /home/vagrant/sync/config/nginx.conf /etc/nginx/nginx.conf
cp /var/www/*/nginx/* /etc/nginx/sites
systemctl restart nginx

# Install & Configure PHP
echo 'Installing & Configuring PHP'
yum -y install php71w php71w-bcmath php71w-cli php71w-common php71w-fpm php71w-gd php71w-intl
yum -y install php71w-mbstring php71w-mcrypt php71w-mysql php71w-pdo php71w-json
yum -y install php71w-xmlrpc php71w-pecl-apcu php71w-pecl-xdebug php71w-soap php71w-xml
cp /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.orig
systemctl enable php-fpm
systemctl start php-fpm
echo ‘cgi.fix_pathinfo=1’ >> /etc/php.ini
echo 'Installed PHP version: '
php --version

# Install & Configure MariaDB
echo 'Installing & Configuring MariaDB'
yum -y install mariadb-server mariadb
systemctl enable mariadb
systemctl start mariadb
echo 'Installed MariaDB version '
mysql --version
# /usr/bin/mysql_secure_installation -- Use non interactive version

# Install Composer
echo 'Installing Composer to /usr/local/bin'
curl -sS https://getcomposer.org/installer | php
chmod +x composer.phar
mv composer.phar /usr/local/bin/composer

# Deal with SELinux on CentOS 7 - see http://stackoverflow.com/questions/6795351/nginx-413-forbidden-for-all-files
setenforce Permissive # Permissive/Enforcing
