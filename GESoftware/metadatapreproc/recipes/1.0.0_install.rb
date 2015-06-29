#
# Cookbook Name:: metadatapreproc
# Recipe:: default
#
# Copyright 2014, Siemens AG
#
# All rights reserved - Do Not Redistribute
#


# Installing MDPP GE

#cookbook_file "#{Chef::Config[:file_cache_path]}/mdpp_resources.tar.gz" do
#  source "mdpp_resources.tar.gz"
remote_file "#{Chef::Config[:file_cache_path]}/mdpp_resources.tar.gz" do
  source "http://repositories.testbed.fi-ware.org/webdav/mdpp_resources.tar.gz"
  action :create
end

# MDPP GE runs only on ubuntu/debian
if node['platform'] != "ubuntu" && node['platform'] != "debian"
	log "*** Sorry, but the MDPP GE requires a debian based OS, like ubuntu - bye  ***"
end

return if node['platform'] != "ubuntu" && node['platform'] != "debian"

apt_package "python" do
  action :install
end

apt_package "mono-complete" do
  action :install
end

bash "install mdpp-files" do
	user "root"
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar xzf mdpp_resources.tar.gz
    ./install.sh
     EOH
end


service "mdppd" do

  case node["platform"]
  when "debian","ubuntu"
    supports :restart => true, :reload => false, :stop => true
  end
	action [:enable, :start]
end
