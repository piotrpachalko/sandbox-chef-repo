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

node.override[:jmxtrans][:jmx_obj]   = "pp:type=KafkaTickTock"
node.override[:jmxtrans][:jmx_alias] = "kafka-producer"
node.override[:jmxtrans][:jmx_attrs] = '"SentPerSecLastMinAvg", "TotalSent"'

include_recipe "role-monitored::with_jmx"

# java
node.override[:java][:install_flavor] = 'openjdk'

include_recipe "java"

# eof
