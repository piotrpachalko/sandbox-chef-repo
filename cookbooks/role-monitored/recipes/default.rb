#
# Cookbook Name:: role-monitored
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.override['ganglia']['cluster_name'] = 'generic'

include_recipe "ganglia"
