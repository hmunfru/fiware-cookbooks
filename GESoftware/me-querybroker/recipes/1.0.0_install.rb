#
# Cookbook Name:: me-querybroker
# Recipe:: default
#
# Copyright 2013, Siemens AG
#
# All rights reserved - Do Not Redistribute
#
#if platform?(%w(debian ubuntu))
#   execute "apt-get update" do
#      command "apt-get -y update"
#   end
#end

include_recipe "tomcat-qb"
#include_recipe "tomcat-qb::users"


#Installing the QueryBroker

#cookbook_file "#{node['tomcat']['webapp_dir']}/QueryBrokerServer.war" do
#  source "QueryBrokerServer.war"
remote_file "#{node['tomcat']['webapp_dir']}/QueryBrokerServer.war" do
  source "http://repositories.testbed.fi-ware.org/webdav/QueryBrokerServer.war"
  mode 0755
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
end

service "tomcat" do
  service_name "tomcat#{node["tomcat"]["base_version"]}"
  case node["platform"]
  when "centos","redhat","fedora"
    supports :restart => true, :status => true
  when "debian","ubuntu"
    supports :restart => true, :reload => false, :status => true
  end
  action [:enable, :start]
  retries 4
  retry_delay 15
end
