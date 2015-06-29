# File: cosmos/recipes/uninstall_hdfs_datanode.rb
# Cookbook: cosmos
# Recipe: uninstall_hdfs_datanode
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Uninstall all the software related to a Datanode daemon.
#
# License...

# Try to stop previous daemons runs
service "hadoop-0.20-datanode" do
        action [ :stop ]
end

# Delete the local Hadoop directories if exist
for dir in node[:hadoop][:all][:jbod_disks]
        directory "#{dir}" do
                recursive true
                action :delete
        end
end

