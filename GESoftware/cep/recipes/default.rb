#
# Cookbook Name:: cep-recipe
# Recipe:: default
#
# Copyright 2013, IBM
#
# All rights reserved - Do Not Redistribute
#
# Installing IBM Proactive Technology Online

cookbook_file "#{node['tomcat']['webapp_dir']}/AuthoringTool.war" do
  source "AuthoringTool.war"
  mode 0755
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
end

cookbook_file "#{node['tomcat']['webapp_dir']}/AuthoringToolWebServer.war" do
  source "AuthoringToolWebServer.war"
  mode 0755
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
end

cookbook_file "#{node['tomcat']['webapp_dir']}/ProtonOnWebServer.war" do
  source "ProtonOnWebServer.war"
  mode 0755
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
end

cookbook_file "#{node['tomcat']['webapp_dir']}/ProtonOnWebServerAdmin.war" do
  source "ProtonOnWebServerAdmin.war"
  mode 0755
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
end

template "#{node['tomcat']['config_dir']}/tomcat-users.xml" do
  owner "root"
  group node["tomcat"]["group"]
  mode "0755"
  source "tomcat-users.xml.erb"
end

template "#{node['tomcat']['bin_dir']}/startup.sh" do
  owner "root"
  group node["tomcat"]["group"]
  mode "0755"
  source "startup.sh.erb"
end

#create a directory for the CEP definitino file
directory "/opt/repositories" do
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
  mode 0755
  action :create
end


#sample file that reads the incoming events from a file 
template "/opt/repositories/DoSAttack.json" do
  owner "root"
  group node["tomcat"]["group"]
  mode "0644"
  source "DoSAttack.json.erb"
end

#sample file that allow sending the incoming events through REST 
template "/opt/repositories/DoSAttack2.json" do
  owner "root"
  group node["tomcat"]["group"]
  mode "0644"
  source "DoSAttack2.json.erb"
end

#create a directory for the CEP sample in/output files
directory "#{node['tomcat']['home']}/sample" do
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
  mode 0755
  action :create
end

#input event scenario for the DosAttack.json definition file
template "#{node['tomcat']['home']}/sample/DoSAttackScenarioJSON.txt" do
  owner "root"
  group node["tomcat"]["group"]
  mode "0644"
  source "DoSAttackScenarioJSON.txt.erb"
end