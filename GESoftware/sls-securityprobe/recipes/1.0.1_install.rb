#
# Cookbook Name:: SecurityProbe
# Recipe:: default
#
# Copyright 2014, ATOS 
#
# All rights reserved - Do Not Redistribute
#
execute "compile-time-apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end.run_action(:run)

include_recipe "python"
#include_recipe "snort"
#include_recipe "rsyslog"

# Create directory for the installation
directory "#{node[:securityprobe][:home]}" do
  owner node[:securityprobe][:user]
  group node[:securityprobe][:group]
  mode 00755
  action :create
end

include_recipe "sls-securityprobe::pre_install_agent"

execute "wget-SecurityProbe" do
  cwd node[:securityprobe][:home]
  command "wget http://repositories.testbed.fi-ware.org/webdav/sls/SecurityProbe.tar.gz" 
end

# Unzip the Security Probe files
execute "untar-SecurityProbe" do
  cwd node[:securityprobe][:home]
  command "tar -zxvf SecurityProbe.tar.gz"
end

# Configure the agent
template "#{node[:securityprobe][:home]}/SecurityProbe/etc/agent/config.cfg" do
  source "ossim_agent_config.cfg.erb"
  mode 0440
  owner node[:securityprobe][:user]
  group node[:securityprobe][:group]
end

# Create var/run directory
directory "/var/run" do
  owner node[:securityprobe][:user]
  group node[:securityprobe][:group]
  mode 00755
  action :create
end

# Create log directory
directory "#{node[:ossim][:log][:path]}" do
  owner node[:securityprobe][:user]
  group node[:securityprobe][:group]
  mode 00755
  action :create
end

bash "install-agent" do
  user node['user']
  group node['group']
    cwd "#{node[:securityprobe][:home]}/SecurityProbe"
    code <<-EOH
set -x
python setup.py install --prefix=/usr 
set +x
EOH
end

include_recipe "sls-securityprobe::post_install_agent"

service "ossim-agent" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start]
end

execute "updaterc-ossim-agent" do
  cwd node[:securityprobe][:home]
  command "update-rc.d ossim-agent start 20 3 4 5 ."
end

directory "#{node[:securityprobe][:home]}/SecurityProbe" do
  recursive true 
  action :delete
end

