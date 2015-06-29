# File: cosmos/recipes/install_hdfs_datanode.rb
# Cookbook: cosmos
# Recipe: install_hdfs_datanode
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Install all the necessary software for a Datanode daemon.
#
# License...

include_recipe "cosmos::install_cdh3_repo"
include_recipe "cosmos::install_hadoop_commons"

# Install the datanode daemon package
package "hadoop-0.20-datanode"

include_recipe "cosmos::create_alternative"
include_recipe "cosmos::configure_hadoop_slave"
include_recipe "cosmos::create_local_directories"

# Configure the daemon to start at boot time
execute "chkconfig hadoop-0.20-datanode on"
