#
# Cookbook Name:: role-kafka-broker
# Recipe:: default
#
# Copyright (c) 2013 Tieto
#
# author: piotr.pachalko@tieto.com
#

# ganglia monitoring
node.override[:ganglia][:cluster_name] = 'kafka-brokers'
node.override[:ganglia][:cluster_id]   = 2

include_recipe "role-monitored"

# java
node.override[:java][:install_flavor] = 'openjdk'

include_recipe "java"

# eof
