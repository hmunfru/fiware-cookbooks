# File: cosmos/recipes/create_alternative.rb
# Cookbook: cosmos
# Recipe: create_alternative
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Create a high priority (50) alternative configuration for hadoop
#
# License...

# Copy the empty configuration into our cosmos configuration
execute "create_cosmos_configuration" do
        command "cp -r /etc/hadoop-0.20/conf.empty /etc/hadoop-0.20/conf.cosmos"
end

# Install a high priority (50) alternative for Cosmos configuration
execute "activate_cosmos_configuration" do
        command "alternatives --install /etc/hadoop-0.20/conf hadoop-0.20-conf /etc/hadoop-0.20/conf.cosmos 50"
end

# Cosmos configuration priority (50) should be enough for being the best alternative,
# but we can set it manually as well
execute "set_comos_configuration" do
        command "alternatives --set hadoop-0.20-conf /etc/hadoop-0.20/conf.cosmos"
end
