#
# Cookbook Name:: role-base
# Recipe:: default
#
# Copyright (c) 2013 Tieto
#
# author: piotr.pachalko@tieto.com
#

# override attributes
# node.override[:foo][:bar] = 'goo'

# Make sure apt tools are there, repos are updated and local packages are clean
include_recipe "apt"
