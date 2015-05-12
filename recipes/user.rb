#
# Cookbook Name:: web_app
# Recipe:: user
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
group node['web_app']['group']

user node['web_app']['user'] do
  group node['web_app']['group']
  system true
  shell '/bin/bash'
end
