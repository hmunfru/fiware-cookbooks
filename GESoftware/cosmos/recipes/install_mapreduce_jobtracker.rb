# File: cosmos/recipes/install_mapreduce_jobtracker.rb
# Cookbook: cosmos
# Recipe: install_mapreduce_jobtracker
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Install any necessary software for a Jobtracker daemon.
#
# License...

include_recipe "cosmos::install_cdh3_repo"
include_recipe "cosmos::install_hadoop_commons"

# Install the jobtracker daemon package
package "hadoop-0.20-jobtracker"

include_recipe "cosmos::create_alternative"
include_recipe "cosmos::configure_hadoop_master"
include_recipe "cosmos::create_local_directories"

# Configure the daemon to start at boot time
execute "chkconfig hadoop-0.20-jobtracker on"
