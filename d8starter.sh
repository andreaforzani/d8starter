#!/bin/bash

shopt -s expand_aliases
alias drush8='~/drush8/vendor/bin/drush'

# Site
##########################################################
siteName="Drupal 8 Site"
siteSlogan="Test drupal 8 site"
siteLocale="en"
##########################################################

# Database
##########################################################
dbHost="localhost"
dbName="d8test"
dbUser="root"
dbPassword="root"
##########################################################

# Admin
##########################################################
AdminUsername="andrea"
AdminPassword="qpwoeiru"
adminEmail="admin@mail.com"
##########################################################

echo -e "////////////////////////////////////////////////////"
echo -e "// Download core"
echo -e "////////////////////////////////////////////////////"

# Download Core
##########################################################

drush8 dl drupal -y --drupal-project-rename="drupal";
mv drupal/{.,}* ./;

rmdir drupal;

mkdir modules/contrib;
mkdir modules/custom;
mkdir modules/features;
mkdir modules/devel;

# mkdir tmp;

echo -e "////////////////////////////////////////////////////"
echo -e "// Install core"
echo -e "////////////////////////////////////////////////////"

# Install core
##########################################################
drush8 site-install -y standard --account-mail=$adminEmail --account-name=$AdminUsername --account-pass=$AdminPassword --site-name=$siteName --site-mail=$adminEmail --locale=$siteLocale --db-url=mysql://$dbUser:$dbPassword@$dbHost/$dbName;

# echo -e "////////////////////////////////////////////////////"
# echo -e "// Download modules and themes"
# echo -e "////////////////////////////////////////////////////"

# Download modules and themes
##########################################################
# drush8 -y dl \
# admin_views \
# adminimal_theme \
# backup_migrate \
# ctools \
# ckeditor \
# ckeditor_link \
# coder \
# date \
# devel \
# diff \
# entity \
# eu_cookie_compliance \
# features \
# fences \
# field_group \
# globalredirect \
# imce \
# jquery_update \
# libraries \
# masquerade \
# menu_block \
# metatag \
# module_filter \
# navbar \
# navbar_flush_cache \
# pathauto \
# redirect \
# simplified_menu_admin \
# social_media_links \
# strongarm \
# token \
# views \
# views_bulk_operations \
# webform \
# xmlsitemap \
# zen;

# Disable some core modules
##########################################################
# drush8 -y dis \
# overlay \
# toolbar;

# mv sites/all/modules/contrib/devel sites/all/modules/devel;
# mv sites/all/modules/contrib/coder sites/all/modules/devel;
# mv sites/all/modules/contrib/diff sites/all/modules/devel;

# echo -e "////////////////////////////////////////////////////"
# echo -e "// Enable modules and themes"
# echo -e "////////////////////////////////////////////////////"

# Enable modules
##########################################################
# drush8 -y en \
# admin_views \
# backup_migrate \
# ctools \
# ckeditor \
# ckeditor_link \
# coder \
# date \
# devel \
# diff \
# entity \
# eu_cookie_compliance \
# features \
# fences \
# field_group \
# globalredirect \
# imce \
# jquery_update \
# libraries \
# masquerade \
# menu_block \
# metatag \
# module_filter \
# navbar \
# navbar_flush_cache \
# pathauto \
# redirect \
# simplified_menu_admin \
# social_media_links \
# strongarm \
# token \
# views \
# views_bulk_operations \
# webform \
# xmlsitemap \
# zen;

#  Call navbar makefile to download libraries dependecies
##########################################################
# drush8 make sites/all/modules/contrib/navbar/navbar.make.example --no-core --shallow-clone

# echo -e "////////////////////////////////////////////////////"
# echo -e "// Pre configure settings"
# echo -e "////////////////////////////////////////////////////"

# Pre configure settings
##########################################################
# disable user pictures
# drush8 vset -y user_pictures 0;
# allow only admins to register users
# drush8 vset -y user_register 0;
# set site slogan
# drush8 vset -y site_slogan $siteSlogan;

# drush8 vset admin_theme adminimal;

echo -e "////////////////////////////////////////////////////"
echo -e "// Install Completed"
echo -e "////////////////////////////////////////////////////"
while true; do
    read -p "press enter to exit" yn
    case $yn in
        * ) exit;;
    esac
done