# File: cosmos/recipes/configure_hadoop_slave.rb
# Cookbook: cosmos
# Recipe: configure_hadoop_slave
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Parameterize Hadoop's XML files
#
# License...

# Get the master node host name. By default it is "localhost"
master_node = "localhost"

# Now, search for those nodes which have an attribute with value node[cosmos_slave_node][cluster_name]
# and have a deployed recipe called 0.9.0_install
search_result = search(
	:node,
	"cluster_name:#{node['cosmos_slave_node']['cluster_name']} AND \
	recipes:cosmos_master_node\\:\\:0.9.0_install"
)

# If the master node has been found, set it. If not, change "localhost" by the localhost hostname
if search_result.size == 0
	master_node = node['hostname']
else
	first_node = search_result[0]
	master_node = first_node['hostname']
end
	
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
