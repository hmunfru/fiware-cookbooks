#include_recipe "java::oracle"
include_recipe "cosmos::install_java"
include_recipe "cosmos::install_hdfs_namenode"
include_recipe "cosmos::install_mapreduce_jobtracker"
include_recipe "cosmos::install_httpfs_server"
include_recipe "cosmos_master_node::0.9.0_start"
