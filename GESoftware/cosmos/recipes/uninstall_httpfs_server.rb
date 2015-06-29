# File: cosmos/recipes/uninstall_https_server
# Cookbook: cosmos
# Recipe: uninstall_https_server
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Uninstall all the software related to a HttpFS server.
#
# License...

# Stop the httpfs server
execute "/usr/local/hadoop-hdfs-httpfs-0.20.2-cdh3u6/sbin/httpfs.sh stop" do
	only_if "ls /usr/local/hadoop-hdfs-httpfs-0.20.2-cdh3u6/sbin/httpfs.sh"
end

# Delete the HttpFS home directory
directory "/usr/local/hadoop-hdfs-httpfs-0.20.2-cdh3u6" do
	recursive true
	action :delete
end
