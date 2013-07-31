#
# Cookbook Name:: role-monitored
# Recipe:: default
#
# Copyright (c) 2013 Tieto
#
# author: piotr.pachalko@tieto.com
#

include_recipe "ganglia"

# add attributes
node.default[:ganglia][:provisioning_if] = "eth1"
node.default[:ganglia][:provisioning_ip] = node[:network][:interfaces]["eth1"][:addresses].find {|addr, addr_info| addr_info[:family] == "inet"}.first
node.default[:ganglia][:cluster_id]      = 1

# override attributes
node.override[:ganglia][:unicast] = false
node.override[:ganglia][:cluster_name] = 'generic-monitored-nodes'

# override template
begin
  t = resources(:template => "/etc/ganglia/gmond.conf")
  t.source "gmond.conf.erb"
  t.cookbook "role-monitored"
  t.variables({
  	:provisioning_if => node[:ganglia][:provisioning_if],
  	:provisioning_ip => node[:ganglia][:provisioning_ip],
  	:cluster_id      => node[:ganglia][:cluster_id],
  	:cluster_name    => node[:ganglia][:cluster_name]
  })
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template '/etc/ganglia/gmond.conf' to modify"
end

