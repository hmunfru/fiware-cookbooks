# File: cosmos/recipes/install_hdfs_namenode.rb
# Cookbook: cosmos
# Recipe: install_hdfs_namenode
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Install all the necessary software for a Namenode daemon
#
# License...

include_recipe "cosmos::install_cdh3_repo"
include_recipe "cosmos::install_hadoop_commons"

# Install the namenode daemon package
package "hadoop-0.20-namenode"

include_recipe "cosmos::create_alternative"
include_recipe "cosmos::configure_hadoop_master"
include_recipe "cosmos::create_local_directories"
include_recipe "cosmos::format_local_fs"

# Configure the daemon to start at boot time
execute "chkconfig hadoop-0.20-namenode on"
