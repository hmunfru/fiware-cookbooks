#
# Cookbook Name:: iotDiscovery
# Recipe:: 4.1.1_stop
#
# Copyright 2014, UNIVERSITY OF SURREY
#
# All rights reserved - Do Not Redistribute
#

service "tomcat7" do
	action :stop
end

service "mysql" do
	action :stop
end

mysql_server 'default' do
  action :stop
end
