#
# Cookbook Name:: cep-recipe
# Recipe:: default
#
# Copyright 2013, IBM
#
# All rights reserved - Do Not Redistribute
#
# Installing IBM Proactive Technology Online

service "tomcat" do
  service_name "tomcat#{node["tomcat"]["base_version"]}"
  action :start
end