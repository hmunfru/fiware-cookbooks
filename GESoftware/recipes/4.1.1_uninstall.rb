#
# Cookbook Name:: iotDiscovery
# Recipe:: 4.1.1_uninstall
#
# Copyright 2014, UNIVERSITY OF SURREY
#
# All rights reserved - Do Not Redistribute
#

directory "/var/lib/tomcat8/webapps/ngsi9" do
    action :delete
    recursive true
end

directory "/var/lib/tomcat8/webapps/s2w" do
    action :delete
    recursive true
end

package "tomcat7" do
  action :remove
end

package "mysql-server" do
  action :remove
end

package "mysql-client" do
  action :remove
end
