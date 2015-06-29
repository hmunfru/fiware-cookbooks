#
# Cookbook Name:: iotDiscovery
# Recipe:: 4.1.1_uninstall
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

directory "/var/lib/tomcat8/webapps/ngsi9" do
    action :delete
    recursive true
end

directory "/var/lib/tomcat8/webapps/s2w" do
    action :delete
    recursive true
end

package "tomcat7-admin" do
  action :remove
end

package "tomcat7" do
  action :remove
end

package "mysql-client" do
  action :remove
end

package "mysql-server" do
  action :remove
end

package "oracle-java8-set-default" do
  action :remove
end

package "oracle-java8-installer" do
  action :remove
end