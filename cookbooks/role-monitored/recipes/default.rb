#
# Cookbook Name:: role-monitored
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "ganglia"

# own attributes
node.default[:'role-monitored'][:provisioning_if] = "eth1"
node.default[:'role-monitored'][:cluster_id]      = 1

# override attributes
node.override['ganglia']['unicast'] = true
node.override['ganglia']['cluster_name'] = 'generic'

# override template
begin
  t = resources(:template => "/etc/ganglia/gmond.conf")
  t.source "gmond.conf.erb"
  t.cookbook "role-monitored"
  t.variables({
     :cluster_name    => node[:ganglia][:cluster_name],
     :provisioning_if => node[:'role-monitored'][:provisioning_if],
     :cluster_id      => node[:'role-monitored'][:cluster_id]
  })
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template '/etc/ganglia/gmond.conf' to modify"
end

