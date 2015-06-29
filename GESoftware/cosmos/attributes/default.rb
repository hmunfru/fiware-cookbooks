# General attributes
# ------------------

default[:cosmos_master_node][:cluster_name] = "test-value"

# Attributes for Hadoop
# ---------------------

# Hadoop common attributes
default[:hadoop][:all][:jbod_disks] = ["/cosmos"]

# core-site.xml
#default[:hadoop][:all][:core_site_xml][:fs_default_name] = "cosmosmaster-gi"

# hdfs-site.xml
default[:hadoop][:all][:hdfs_site_xml][:dfs_name_dir] = ["/cosmos/namenode"]
default[:hadoop][:all][:hdfs_site_xml][:dfs_data_dir] = ["/cosmos/datanode"]
#default[:hadoop][:all][:hdfs_site_xml][:dfs_thrift_address] = "cosmosmaster-gi"

# mapred-site.xml
#default[:hadoop][:all][:mapred_site_xml][:mapred_job_tracker] = "cosmosmaster-gi"
default[:hadoop][:all][:mapred_site_xml][:mapred_local_dirs] = ["/cosmos/mapred"]
default[:hadoop][:all][:mapred_site_xml][:mapred_reduce_tasks] = 9
default[:hadoop][:all][:mapred_site_xml][:mapred_tasktracker_reduce_tasks_maximum] = 10
#default[:hadoop][:all][:mapred_site_xml][:jobtracker_thrift_address] = "cosmosmaster-gi"

# Attributes for SFTP
# -------------------

default[:sftp][:port] = 2222

# Attributes for MySQL (frontend one)
# -----------------------------------

default[:mysql][:password] = "67tyugh"
