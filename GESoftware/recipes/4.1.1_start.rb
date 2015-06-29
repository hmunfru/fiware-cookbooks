#
# Cookbook Name:: iotDiscovery
# Recipe:: 4.1.1_start
#
# Copyright 2014, UNIVERSITY OF SURREY
#
# All rights reserved - Do Not Redistribute
#

service "tomcat7" do
	action :start
end

service "mysql" do
	action :start
end

# mysql_server 'default' do
  # action :start
# end