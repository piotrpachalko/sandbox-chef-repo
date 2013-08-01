#
# Cookbook Name:: role-monitored
# Recipe:: with_jmx
#
# Copyright (c) 2013 Tieto
#
# author: piotr.pachalko@tieto.com
#

# java
node.override[:java][:install_flavor] = 'openjdk'

include_recipe "java"

# jmxtrans
node.default[:jmxtrans][:version]   = '20121016-175251-ab6cfd36e3-1'
node.default[:jmxtrans][:uri]       = 'https://github.com/downloads/jmxtrans/jmxtrans/jmxtrans_20121016-175251-ab6cfd36e3-1_all.deb'
node.default[:jmxtrans][:checksum]  = '1b239b85'
node.default[:jmxtrans][:jmx_port]  = 9999
node.default[:jmxtrans][:jmx_obj]   = 'java.lang:type=Runtime'
node.default[:jmxtrans][:jmx_alias] = nil
node.default[:jmxtrans][:jmx_attrs] = '"Uptime"'

remote_file "/usr/src/jmxtrans-stable-#{node[:jmxtrans][:version]}.deb" do
  source node[:jmxtrans][:uri]
  checksum node[:jmxtrans][:checksum]
end

dpkg_package 'jmxtrans' do
  source "/usr/src/jmxtrans-stable-#{node[:jmxtrans][:version]}.deb"
end

template "/var/lib/jmxtrans/jmx-to-ganglia.json" do
    source "jmx-to-ganglia.json.erb"
    variables({
      :jmx_port        => node[:jmxtrans][:jmx_port],
      :jmx_obj         => node[:jmxtrans][:jmx_obj],
      :jmx_alias       => node[:jmxtrans][:jmx_alias],
      :jmx_attrs       => node[:jmxtrans][:jmx_attrs],
      :provisioning_ip => node[:ganglia][:provisioning_ip],
      :cluster_id      => node[:ganglia][:cluster_id],
      :cluster_name    => node[:ganglia][:cluster_name]
    }) 
    notifies :restart, "service[jmxtrans]"
end

service "jmxtrans" do
  supports :restart => true
  action [ :enable, :start ]
end

# eof
