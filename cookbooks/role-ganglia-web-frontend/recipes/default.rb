#
# Cookbook Name:: role-ganglia-web-frontend
# Recipe:: default
#
# Copyright (c) 2013 Tieto
#
# author: piotr.pachalko@tieto.com
#
include_recipe "ganglia::web"
include_recipe "ganglia::gmetad"

# own attributes
#node.default[:'role-monitored'][:provisioning_if] = "eth1"
#node.default[:'role-monitored'][:cluster_id]      = 1

# override attributes
#node.override['ganglia']['cluster_name'] = 'ganglia-web-frontend'
node.override[:ganglia][:unicast] = false

# override template
clusters = Hash.new {|h,k| h[k]=[]} # fancy initializer that auto-creates arrays for new hash entries
search(:node, "role:monitored").each do |n|
  name = n[:ganglia][:cluster_name]
  ip   = n[:ganglia][:provisioning_ip]
  port = n[:ganglia][:cluster_id].to_i + 10000
 
  if not ip.nil? then clusters[name] << "#{ip}:#{port}" end
    
end

begin
  t = resources(:template => "/etc/ganglia/gmetad.conf")
  t.source "gmetad.conf.erb"
  t.cookbook "role-ganglia-web-frontend"
  t.variables({
  	 :clusters        => clusters
  })
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template '/etc/ganglia/gmetad.conf' to modify"
end
