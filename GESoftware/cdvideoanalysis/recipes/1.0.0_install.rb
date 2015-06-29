#
# Cookbook Name:: cdvideoanalysis
# Recipe:: default
#
# Copyright 2013, Siemens AG
#
# All rights reserved - Do Not Redistribute
#


# Installing CDVA GE

#cookbook_file "#{Chef::Config[:file_cache_path]}/cdva_resources.tar.gz" do
#  source "cdva_resources.tar.gz"
remote_file "#{Chef::Config[:file_cache_path]}/cdva_resources.tar.gz" do
  source "http://repositories.testbed.fi-ware.org/webdav/cdva_resources.tar.gz"
  action :create
end

# CDVA GE runs only on ubuntu/debian
if node['platform'] != "ubuntu" && node['platform'] != "debian"
	log "*** Sorry, but the CDVA GE requires a debian based OS, like ubuntu - bye  ***"
end

return if node['platform'] != "ubuntu" && node['platform'] != "debian"

bash "install cdva-files" do
	user "root"
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar xzf cdva_resources.tar.gz
    ./install.sh
     EOH
end


service "codoand" do

  case node["platform"]
  when "debian","ubuntu"
    supports :restart => true, :reload => false, :stop => true
  end
	action [:enable, :start]
end
