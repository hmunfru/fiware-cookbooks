#
# Cookbook Name:: semanticas
# Recipe:: default
#
# Copyright 2013, ATOS
#
# All rights reserved - Do Not Redistribute
#

service "jboss" do
  action :stop
end

service "tomcat" do
  service_name "tomcat#{node["tomcat"]["base_version"]}"
  action :stop
end
