# File: cosmos/recipes/configure_hadoop_master.rb
# Cookbook: cosmos
# Recipe: configure_hadoop_master
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Parameterize Hadoop's XML files
#
# License...

# Get the master node hostname
master_node = node['hostname']

# Configure the Hadoop core through core-site.xml
template "/etc/hadoop-0.20/conf.cosmos/core-site.xml" do
        source "hadoop-conf/core-site.xml.erb"
        variables(
                :fs_default_name => master_node
        )
end

# Configure the MapReduce engine through mapred-site.xml
template "etc/hadoop-0.20/conf.cosmos/mapred-site.xml" do
        source "hadoop-conf/mapred-site.xml.erb"
        variables(
                :mapred_job_tracker => master_node,
                :mapred_local_dirs => node[:hadoop][:all][:mapred_site_xml][:mapred_local_dirs].join(","),
                :mapred_reduce_tasks => node[:hadoop][:all][:mapred_site_xml][:mapred_reduce_tasks],
                :mapred_tasktracker_reduce_tasks_maximum => node[:hadoop][:all][:mapred_site_xml][:mapred_tasktracker_reduce_tasks_maximum],
                :jobtracker_thrift_address => master_node
        )
end

# Configure the HDFS through hdfs-site.xml
template "etc/hadoop-0.20/conf.cosmos/hdfs-site.xml" do
        source "hadoop-conf/hdfs-site.xml.erb"
        variables(
                :dfs_name_dir => node[:hadoop][:all][:hdfs_site_xml][:dfs_name_dir].join(","),
                :dfs_data_dir => node[:hadoop][:all][:hdfs_site_xml][:dfs_data_dir].join(","),
                :dfs_thrift_address => master_node
        )
end
