#Cookbook Name:: sls 
# Recipe:: default
#
# Copyright 2014, ATOS
#
# All rights reserved - Do Not Redistribute
#

service "alienvault-idm" do
  action :start
end

service "ossim-framework" do
  action :start
end

service "ossim-server" do
  action :start
end

service "ossim-socat" do
  action :start
end

service "ossim-agent" do
  action :start
end

service "zookeeper" do
  action :start
end

service "storm-nimbus" do
  action :start
end

service "storm-ui" do
  action :start
end

service "storm-supervisor" do
  action :start
end


