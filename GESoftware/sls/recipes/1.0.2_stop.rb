#Cookbook Name:: sls 
# Recipe:: default
#
# Copyright 2014, ATOS
#
# All rights reserved - Do Not Redistribute
#

service "ossim-agent" do
  action :stop
end

service "ossim-server" do
  action :stop
end

service "ossim-socat" do
  action :stop
end

service "ossim-framework" do
  action :stop
end

service "alienvault-idm" do
  action :stop
end

#include_recipe "sls::stopSLSTopology"

service "storm-ui" do
  action :stop
end

service "storm-supervisor" do
  action :stop
end

service "storm-nimbus" do
  action :stop
end

service "zookeeper" do
  action :stop
end

