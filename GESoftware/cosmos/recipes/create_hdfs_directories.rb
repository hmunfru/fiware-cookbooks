# File: cosmos/recipes/create_hdfs_directories.rb
# Cookbook: cosmos
# Recipe: create_hdfs_directories
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Create /tmp and /mapred/system directories in HDFS.
#              This can only be done once the HDFS daemons have been started.
#
# License...

# Create the HDFS /tmp directory; the "directory" Chef resource cannot be used since the directory
# must be created within HFDS by using specific "hadoop fs" commands such as "-mkdir" and "-chmod"
execute "create_hdfs_tmp_dir" do
        command "hadoop fs -mkdir /tmp"
	user "hdfs"
        not_if "sudo -u hdfs hadoop fs -ls / | grep tmp"
end

execute "hadoop fs -chmod -R 1777 /tmp" do
	user "hdfs"
end

# Create and configure the mapred.system.dir directory in HDFS
# must be created within HFDS by using specific "hadoop fs" commands such as "-mkdir" and "-chown"
execute "create_hdfs_mapred_system_dir" do
        command "hadoop fs -mkdir /mapred/system"
	user "hdfs"
        not_if "sudo -u hdfs hadoop fs -ls / | grep mapred"
end

execute "hadoop fs -chown mapred:hadoop /mapred/system" do
	user "hdfs"
end
