# Role definition
name "kafka-broker"
description "Kafka broker nodes"

# Attributes applied if the node doesn't have it set already.
default_attributes(
  "java"    => { "install_flavor" => "openjdk" },
  "ganglia" => { "cluster_name" => "kafka-brokers" }
)

run_list(
  "recipe[java]"
)
