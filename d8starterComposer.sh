#!/bin/bash

shopt -s expand_aliases
alias drush8='~/drush8/vendor/bin/drush'

# Site
##########################################################
siteName="YourSiteName"
siteSlogan="Your Site Slogan"
siteLocale="en"
##########################################################

# Database
##########################################################
dbHost="localhost"
dbName="yourdbname"
dbUser="yourdbuser"
dbPassword="yourdbpassword"
##########################################################

# Admin
##########################################################
AdminUsername="adminusername"
AdminPassword="adminpassword!"
adminEmail="admin@mail.com"
##########################################################

echo -e "////////////////////////////////////////////////////"
echo -e "// Download core"
echo -e "////////////////////////////////////////////////////"

# Download Core
##########################################################

composer create-project drupal-composer/drupal-project:~8.0 drupal --stability dev --no-interaction

mv drupal/{.,}* ./;
rmdir drupal;

cd web;

mkdir modules/contrib;
mkdir modules/custom;
mkdir modules/features;
# mkdir modules/devel;

mkdir tmp;

echo -e "////////////////////////////////////////////////////"
echo -e "// Install core"
echo -e "////////////////////////////////////////////////////"

# Install core
##########################################################
drush8 site-install -y standard --account-mail=$adminEmail --account-name=$AdminUsername --account-pass=$AdminPassword --site-name=$siteName --site-mail=$adminEmail --locale=$siteLocale --db-url=mysql://$dbUser:$dbPassword@$dbHost/$dbName;

echo -e "////////////////////////////////////////////////////"
echo -e "// Download modules and themes"
echo -e "////////////////////////////////////////////////////"

# # Download modules and themes
# ##########################################################
composer require \
drupal/admin_toolbar \
drupal/adminimal_admin_toolbar \
drupal/adminimal_theme \
# drupal/backup_migrate \ read https://www.drupal.org/node/2822885#comment-11980694
drupal/ctools \
drupal/devel \
drupal/diff \
drupal/entity \
drupal/eu_cookie_compliance \
drupal/features \
drupal/fences \
drupal/field_group \
drupal/imce \
drupal/libraries \
drupal/linkit \
drupal/masquerade \
drupal/menu_block \
drupal/metatag \
drupal/module_filter \
drupal/pathauto \
drupal/redirect \
drupal/social_media_links \
drupal/token \
drupal/toolbar_menu \
drupal/webform \
drupal/simple_sitemap \
drupal/environment_indicator \
drupal/basic;

echo -e "////////////////////////////////////////////////////"
echo -e "// Enable modules and themes"
echo -e "////////////////////////////////////////////////////"

# # Enable modules
# ##########################################################
drush8 -y en \
admin_toolbar \
adminimal_admin_toolbar \
adminimal_theme \
# backup_migrate \
ctools \
devel \
diff \
entity \
eu_cookie_compliance \
features \
fences \
field_group \
imce \
libraries \
linkit \
masquerade \
menu_block \
metatag \
module_filter \
pathauto \
redirect \
social_media_links \
token \
toolbar_menu \
webform \
simple_sitemap \
environment_indicator \
basic;

# # Enable secondary modules
# ##########################################################
drush8 -y en \
admin_toolbar_tools \
ctools_views \
ctools_block \
kint \
features_ui;


echo -e "////////////////////////////////////////////////////"
echo -e "// Pre configure settings"
echo -e "////////////////////////////////////////////////////"

# # Pre configure settings
# ##########################################################
# # disable user pictures
# # drush8 vset -y user_pictures 0;
# # allow only admins to register users
drush8 cset system.site register admin_only -y;
# # set site name
drush8 cset system.site name $siteName -y;
# # set site slogan
drush8 cset system.site slogan $siteSlogan -y;

# drush8 cset system.theme admin adminimal -y;

echo -e "////////////////////////////////////////////////////"
echo -e "// Install Completed"
echo -e "////////////////////////////////////////////////////"
while true; do
    read -p "press enter to exit" yn
    case $yn in
        * ) exit;;
    esac
done