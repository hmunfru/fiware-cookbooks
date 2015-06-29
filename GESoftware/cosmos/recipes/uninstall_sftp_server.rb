# File: cosmos/recipes/uninstall_sftp_server
# Cookbook: cosmos
# Recipe: uninstall_sftp_server
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Uninstall all the software related to a SFTP server.
#
# License...

# Try to stop a previous run of the service
execute "/etc/init.d/injection stop" do
	only_if "ls -la /etc/init.d/injection"
end

# Delete the service directories 
directory "/usr/local/injection" do
	recursive true
	action :delete
end

directory "/etc/injection" do
	recursive true
	action :delete
end

directory "/var/log/injection" do
	recursive true
	action :delete
end

directory "/var/run/injection" do
	recursive true
	action :delete
end

