#
# Cookbook Name:: web_app
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
include_recipe 'selinux::permissive'
include_recipe 'web_app::user'
include_recipe 'web_app::webserver'
include_recipe 'web_app::database'
