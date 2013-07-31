#
# Chef role definition 
# for monitored nodes
#
# Copyright (c) 2013 Tieto
#
# author: piotr.pachalko@tieto.com
# 
name        "monitored"
description "Node that is monitored by Ganglia"

# We use no-role pattern, actual role is defined in a dedicated, versioned cookbook
run_list("recipe[role-monitored]")

# eof
