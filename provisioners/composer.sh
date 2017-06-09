# Install Laravel Installer - Doesn't like running Composer as sudo
echo 'Installing Laravel Installer'
composer global require "laravel/installer"
echo 'export PATH="$PATH:$HOME/.config/composer/vendor/bin/"' >> ~/.bashrc
source ~/.bashrc
echo 'Installed Laravel Installer version '
laravel --version
