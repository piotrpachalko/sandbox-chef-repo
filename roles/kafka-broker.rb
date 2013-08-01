#
# Chef role definition 
# for kafka broker nodes
#
# Copyright (c) 2013 Tieto
#
# author: piotr.pachalko@tieto.com
# 
name "kafka-broker"
description "Kafka broker nodes"

# We use no-role pattern, actual role is defined in a dedicated, versioned cookbook
run_list("recipe[role-kafka-broker]")

# eof
