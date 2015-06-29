# File: cosmos/recipes/install_mapreduce_tasktracker.rb
# Cookbook: cosmos
# Recipe: install_mapreduce_tasktracker
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Install all the necessary software for a Tasktracker daemon.
#
# License...

include_recipe "cosmos::install_cdh3_repo"
include_recipe "cosmos::install_hadoop_commons"

# Install the tasktracker daemon package
package "hadoop-0.20-tasktracker"

include_recipe "cosmos::create_alternative"
include_recipe "cosmos::configure_hadoop_slave"
include_recipe "cosmos::create_local_directories"

# Configure the daemon to start at boot time
execute "chkconfig hadoop-0.20-tasktracker on"
