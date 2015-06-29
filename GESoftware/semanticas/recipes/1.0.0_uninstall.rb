#
# Cookbook Name:: semanticas
# Recipe:: default
#
# Copyright 2013, ATOS
#
# All rights reserved - Do Not Redistribute
#

directory "#{node['tomcat']['webapp_dir']}/openrdf-sesame" do
  action : delete
end

file "#{node['tomcat']['webapp_dir']}/openrdf-sesame.war" do
  action : delete
end

directory "#{node['tomcat']['webapp_dir']}/semantic-workspaces-service" do
  action : delete
end

file "#{node['tomcat']['webapp_dir']}/semantic-workspaces-service.war" do
  action : delete
end

file "#{node['jboss']['jboss_home']}/standalone/deployments/ontology-registry-service.war" do
  action : delete
end

mysql_database 'semanticas_ontoregistry' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :drop
end

mysql_database 'semanticas_workspaces' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :drop
end

directory "#{node['tomcat']['home']}/.aduna" do
  action :delete
end
