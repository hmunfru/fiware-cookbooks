# File: cosmos/recipes/configure_network
# Cookbook: cosmos
# Recipe: configure_network
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Networking
#
# License...

# Set the hostname for the current session; this is lost when rebooting
execute "set_hostname_session" do
        command "hostname #{node[:hostname_]}"
end

# Set the hostname in a permanently way; it does not affect the current session (it
# does only after rebooting)
execute "set_hostname_permanently" do
        command "echo HOSTNAME=#{node[:hostname_]} >> /etc/sysconfig/network"
        not_if "cat /etc/sysconfig/network | grep HOSTNAME=#{node[:hostname_]}"
end

# Include all the cluster members fqdn resolution in /etc/hosts
keys = node[:hadoop][:all][:fqdn_ip_hash].keys
for key in keys
        append_to_file "append_to_etc_hosts" do
                line "#{node[:hadoop][:all][:fqdn_ip_hash][key]} #{key}"
                file "/etc/hosts"
        end
end
