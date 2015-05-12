#
# Cookbook Name:: web_app
# Recipe:: webserver
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# Install Apache and configure its service.
include_recipe 'apache2::default'

# Create and enable our custom site.
web_app node['web_app']['name'] do
  template "#{node['web_app']['config']}.erb"
end

# Create the document root.
directory node['apache']['docroot_dir'] do
  recursive true
end

# Load the secrets file and the encrypted data bag item that holds the database password.
password_secret = Chef::EncryptedDataBagItem.load_secret("#{node['web_app']['passwords']['secret_path']}")
user_password_data_bag_item = Chef::EncryptedDataBagItem.load('passwords', 'db_admin', password_secret)

# Write a default home page.
template "#{node['apache']['docroot_dir']}/index.php" do
  source 'index.php.erb'
  mode '0644'
  owner node['web_app']['user']
  group node['web_app']['group']
  variables({
    :database_password => user_password_data_bag_item['password']
  })
end

# Install the mod_php5 Apache module.
include_recipe 'apache2::mod_php5'

# Install php-mysql.
package "#{node['web_app']['php-mysql-package']}" do
  action :install
  notifies :restart, 'service[apache2]'
end