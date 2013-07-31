#
# Chef role definition 
# for ganglia-web-frontend nodes nodes
#
# Copyright (c) 2013 Tieto
#
# author: piotr.pachalko@tieto.com
# 
name "ganglia-web-frontend"
description "Node that acts as a ganglia monitor web frontend"

# We use no-role pattern, actual role is defined in a dedicated, versioned cookbook
run_list("recipe[role-ganglia-web-frontend]")

# eof
