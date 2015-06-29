#
# Cookbook Name:: me-querybroker
# Recipe:: default
#
# Copyright 2013, Siemens AG
#
# All rights reserved - Do Not Redistribute
#

service "tomcat" do
  service_name "tomcat#{node["tomcat"]["base_version"]}"
  action :stop
end

