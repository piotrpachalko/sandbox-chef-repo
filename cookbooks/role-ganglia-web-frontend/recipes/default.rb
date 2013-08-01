#
# Cookbook Name:: role-ganglia-web-frontend
# Recipe:: default
#
# Copyright (c) 2013 Tieto
#
# author: piotr.pachalko@tieto.com
#

# gmond
node.override[:ganglia][:cluster_name] = 'ganglia-web-frontend'
node.override[:ganglia][:cluster_id]   = 1
include_recipe "role-monitored"

# gmetad
include_recipe "ganglia::gmetad"

# override template
clusters = Hash.new {|h,k| h[k]=[]} # fancy initializer that auto-creates arrays for new hash entries
search(:node, "role:base").each do |n|
  name = n[:ganglia][:cluster_name]
  ip   = n[:ganglia][:provisioning_ip]
  port = n[:ganglia][:cluster_id].to_i + 10000
 
  if not ip.nil? then clusters[name] << "#{ip}:#{port}" end
end

Chef::Log.warn clusters.to_s

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

# web app
include_recipe "ganglia::web"

# eof
