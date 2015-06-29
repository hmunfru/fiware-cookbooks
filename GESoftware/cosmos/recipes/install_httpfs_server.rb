# File: cosmos/recipes/install_httpfs_server.rb
# Cookbook: cosmos
# Recipe: install_httpfs_server
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Install a HttpFS server implementing the WebHDFS REST API (basic HDFS I/O).
#
# License...

# Stop previous runs of the httpfs server
execute "/usr/local/hadoop-hdfs-httpfs-0.20.2-cdh3u6/sbin/httpfs.sh stop"

# Download the binaries as tar file
remote_file "#{Chef::Config[:file_cache_path]}/hadoop-hdfs-httpfs-0.20.2-cdh3u6.tar.gz" do
        source "http://130.206.80.64/repo/files/hadoop-hdfs-httpfs-0.20.2-cdh3u6.tar.gz"
        mode 0700
end

# Detele previous HttpFS home directories
directory "/usr/local/hadoop-hdfs-httpfs-0.20.2-cdh3u6" do
	recursive true
	action :delete
	only_if "ls /usr/local/hadoop-hdfs-httpfs-0.20.2-cdh3u6"
end

# Untar the binaries and move them to the HttpFS home directory
bash "untar_httpfs" do
	cwd "#{Chef::Config[:file_cache_path]}"
	code <<-EOH
		tar xzf hadoop-hdfs-httpfs-0.20.2-cdh3u6.tar.gz
		mv hadoop-hdfs-httpfs-0.20.2-cdh3u6 /usr/local/
	EOH
end

# Configure the server
template "/usr/local/hadoop-hdfs-httpfs-0.20.2-cdh3u6/etc/hadoop/httpfs-site.xml" do
	source "httpfs-conf/httpfs-site.xml.erb"
end
