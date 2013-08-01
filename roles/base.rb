#
# Chef role definition 
# base - for all the nodes
#
# Copyright (c) 2013 Tieto
#
# author: piotr.pachalko@tieto.com
# 
name "base"
description "Base recipes for all the Ubuntu nodes"

# We use no-role pattern, actual role is defined in a dedicated, versioned cookbook
run_list("recipe[role-base]")

# eof
