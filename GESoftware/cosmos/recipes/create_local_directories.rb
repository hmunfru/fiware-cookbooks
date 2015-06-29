# File: cosmos/recipes/create_local_directories.rb
# Cookbook: cosmos
# Recipe: create_local_directories
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Create the local directories for Hadoop (local OS-based folders where to store
#              HDFS metadata, temporal results, etc.
#
# License...

# Create the Cosmos home directory
for dir in node[:hadoop][:all][:jbod_disks]
	directory "#{dir}" do
		recursive true
		action :delete
		only_if "ls #{dir}"
	end

        directory "#{dir}" do
                owner "hdfs"
                group "hadoop"
                mode "755" # Cloudera says 700 but it does not work!
                recursive true
                action :create
        end
end

# Create a subdirectory for the Namenode under Cosmos home directory
for dir in node[:hadoop][:all][:jbod_disks]
	directory "#{dir}/namenode" do
                action :delete
		only_if "ls #{dir}/namenode"
        end

        directory "#{dir}/namenode" do
                owner "hdfs"
                group "hadoop"
                mode "755" # Cloudera says 700 but it does not work!
                action :create
        end
end

# Create a subdirectory for the Datanodes under Cosmos home directory
for dir in node[:hadoop][:all][:jbod_disks]
	directory "#{dir}/datanode" do
                action :delete
                only_if "ls #{dir}/datanode"
        end

        directory "#{dir}/datanode" do
                owner "hdfs"
                group "hadoop"
                mode "755" # Cloudera says 700 but it does not work!
                action :create
        end
end

# Create a subdirectory for the MapReduce jobs under Cosmos home directory
for dir in node[:hadoop][:all][:jbod_disks]
	directory "#{dir}/mapred" do
                action :delete
                only_if "ls #{dir}/mapred"
        end

        directory "#{dir}/mapred" do
                owner "mapred"
                group "hadoop"
                mode "755"
                action :create
        end
end
