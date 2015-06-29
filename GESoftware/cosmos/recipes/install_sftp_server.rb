# File: cosmos/recipes/install_sftp_server.rb
# Cookbook: cosmos
# Recipe: install_sftp_server
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Install a SFTP server compatible with HDFS.
#
# License...

# Create the directories the SFTP server needs
directory "/usr/local/injection"
directory "/etc/injection"
directory "/var/log/injection"
directory "/var/run/injection"

# Copy the binary from the repository
remote_file "/usr/local/injection/injection-server.jar" do
	source "https://forge.fi-ware.eu/frs/download.php/453/injection-server.jar"
end

# Install the service script for the SFTP server
template "/etc/init.d/injection" do
        source "sftp-conf/injection.erb"
	mode 0755
end

# Create the SFTP server configuration file
template "/etc/injection/injection.cfg" do
	source "sftp-conf/injection.cfg.erb"
		mode 0644
		variables(
			:sftp_port => node[:sftp][:port],
			:namenode_host => node[:hadoop][:all][:fqdn_ip_hash]["cosmosmaster-gi"],
			:mysql_password => node[:mysql][:password]
		)
end

# Open the SFTP listening port
open_input_tcp_port "open_input_tcp_port_2222" do
	port 2222
end
