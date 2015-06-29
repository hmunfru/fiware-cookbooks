#
# Cookbook Name:: cep-recipe
# Recipe:: default
#
# Copyright 2013, IBM
#
# All rights reserved - Do Not Redistribute
#
# #Installing IBM Proactive Technology Online

directory "#{node['tomcat']['webapp_dir']}/AuthoringTool.war" do
  action : delete
end

file "#{node['tomcat']['webapp_dir']}/AuthoringTool.war" do
  action : delete
end

directory "#{node['tomcat']['webapp_dir']}/AuthoringToolWebServer.war" do
  action : delete
end

file "#{node['tomcat']['webapp_dir']}/AuthoringToolWebServer.war" do
  action : delete
end

directory "#{node['tomcat']['webapp_dir']}/ProtonOnWebServer.war" do
  action : delete
end

file "#{node['tomcat']['webapp_dir']}/ProtonOnWebServer.war" do
  action : delete
end

directory "#{node['tomcat']['webapp_dir']}/ProtonOnWebServerAdmin.war" do
  action : delete
end

file "#{node['tomcat']['webapp_dir']}/ProtonOnWebServerAdmin.war" do
  action : delete
end

#definition repository dir
directory "/opt/repositories" do
  action : delete
end

#sample dir 
directory "#{node['tomcat']['home']}/sample" do
  action : delete
end



