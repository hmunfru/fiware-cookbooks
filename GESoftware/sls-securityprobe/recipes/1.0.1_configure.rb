#
# Cookbook Name:: SecurityProbe
# Recipe:: default
#
# Copyright 2014, ATOS 
#
# All rights reserved - Do Not Redistribute
#

# Configure the agent
template "/etc/agent/config.cfg" do
  source "ossim_agent_config.cfg.erb"
  mode 0644
  owner node[:securityprobe][:user]
  group node[:securityprobe][:group]
end

service "ossim-agent" do
  action :restart
end


