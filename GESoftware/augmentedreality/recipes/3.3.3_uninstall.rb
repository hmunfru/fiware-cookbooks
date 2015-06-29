#
# Cookbook Name:: augmentedreality
# Recipe:: uninstall
#
# Copyright 2014, CIE, University of Oulu
#
# All rights reserved - Do Not Redistribute
#

#if node[:platform_family] == "debian"
#	bash "uninstall_and_configure_software_debian" do
#		user "root"
#		cwd "/tmp"
#		code <<-EOT
#			rm -r /var/www/MIWI-AugmentedReality_3.3.3
#		EOT
#	end
#end

#if node[:platform_family] == "rhel"
        bash "uninstall_and_configure_software" do
                user "root"
                cwd "/tmp"
                code <<-EOT
                        rm -r /var/www/html/MIWI-AugmentedReality_3.3.3
                EOT
        end
end

