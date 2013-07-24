# Role definition
name "ganglia-web-frontend"
description "Node that acts as a ganglia monitor web frontend"

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list("recipe[ganglia::web]")

# Attributes applied if the node doesn't have it set already.
#default_attributes()

# Attributes applied no matter what the node has set already.
#override_attributes()