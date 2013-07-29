# Role definition
name        "monitored"
description "Node that is monitored by Ganglia"

# We use no-role pattern, actual role is defined in a dedicated cookbook
run_list("recipe[role-monitored]")

# eof
