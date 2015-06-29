# File: cosmos/recipes/uninstall_hdfs_namenode
# Cookbook: cosmos
# Recipe: uninstall_hdfs_namenode
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Uninstall all the software related to a Namenode daemon.
#
# License...

# Try to stop previous daemons runs
service "hadoop-0.20-namenode" do
        action [ :stop ]
end

# Delete the local Hadoop directories if exist
for dir in node[:hadoop][:all][:jbod_disks]
        directory "#{dir}" do
                recursive true
                action :delete
        end
end

