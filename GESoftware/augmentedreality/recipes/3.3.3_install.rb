#
# Cookbook Name:: augmentedreality
# Recipe:: install
#
# Copyright 2014, CIE, University of Oulu
#
# All rights reserved - Do Not Redistribute
#

package node["apache"]["package_name"] do
  action :install
end

package "unzip" do
  action :install
end

remote_file "/tmp/MIWI-AugmentedReality_3.3.3.zip" do
	source "http://forge.fi-ware.org/frs/download.php/1205/MIWI-AugmentedReality_3.3.3.zip"
end
# if node[:platform_family] == "debian"
#	bash "install_and_configure_software_debian" do
#		user "root"
#		cwd "/tmp"
#		code <<-EOT
#			unzip MIWI-AugmentedReality_3.3.3.zip
#			cp -r MIWI-AugmentedReality_3.3.3 /var/www/
#		EOT
#	end
#end

#if node[:platform_family] == "rhel"
        bash "install_and_configure_software" do
                user "root"
                cwd "/tmp"
                code <<-EOT
                        unzip MIWI-AugmentedReality_3.3.3.zip
                        cp -r MIWI-AugmentedReality_3.3.3 /var/www/html/
                EOT
        end
#end

service node["apache"]["service_name"] do
        action :start
end
