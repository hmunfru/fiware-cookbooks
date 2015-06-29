#
# Cookbook Name:: me-querybroker
# Recipe:: default
#
# Copyright 2013,  Siemens AG
#
# All rights reserved - Do Not Redistribute
#

directory "#{node['tomcat']['webapp_dir']}/QueryBrokerServer" do
  recursive true
  action :delete
end

file "#{node['tomcat']['webapp_dir']}/QueryBrokerServer.war" do
  action :delete
end


