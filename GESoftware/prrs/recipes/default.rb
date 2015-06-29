#
# Cookbook Name:: semanticas
# Recipe:: default
#
# Copyright 2013, ATOS
#
# All rights reserved - Do Not Redistribute
#

include_recipe "tomcat-semanticas"
include_recipe "mysql-semanticas"
node.set['mysql']['bind_address']="0.0.0.0"
include_recipe "mysql-semanticas::server"
include_recipe "database-semanticas"
include_recipe "database-semanticas::mysql"

#Setting MySQL Databases

mysql_database 'securityrepository' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end

mysql_database 'prrscontextmanager' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end

mysql_connection_info = {:host => "localhost",:username => 'root',:password => node['mysql']['server_root_password']}

mysql_database_user "#{node['prrs']['database_user']}" do
  connection mysql_connection_info
  password "#{node['prrs']['database_password']}"
  action :create
end

execute "download-PRRS_Web_Console" do
  cwd node['tomcat']['webapp_dir']
  command "wget http://repositories.testbed.fi-ware.org/webdav/prrs/prrsWebConsole.war" 
end

directory "#{node['prrs']['home']}" do
  owner node["prrs"]["user"]
  group node["prrs"]["group"]
  mode 00755
  action :create
end

directory "#{node['prrs']['home']}/PRRS-Karaf-3.3.3" do
  owner node["prrs"]["user"]
  group node["prrs"]["group"]
  mode 00755
  action :create
end

directory "#{node['prrs']['home']}/PRRS-Karaf-3.3.3/PRRS_installation" do
  owner node["prrs"]["user"]
  group node["prrs"]["group"]
  mode 00755
  action :create
end

directory "#{node['prrs']['home']}/PRRS-Karaf-3.3.3/PRRS_installation/conf" do
  owner node["prrs"]["user"]
  group node["prrs"]["group"]
  mode 00755
  action :create
end

execute "download-PRRS_Karaf" do
  cwd node["prrs"]["home"]
  command "wget http://repositories.testbed.fi-ware.org/webdav/prrs/PRRS-Karaf-3.3.3.tar.gz" 
end

execute "untar-PRRS_Karaf" do
  cwd node["prrs"]["home"]
  command "tar -zxvf PRRS-Karaf-3.3.3.tar.gz" 
end

execute "create-tables-securityrepository" do
 command "mysql -u root --password=#{node['mysql']['server_root_password']}  < #{node['prrs']['home']}/PRRS-Karaf-3.3.3/PRRS_installation/databases/security_repository.sql"
end

execute "create-tables-prrscontextmanager" do
 command "mysql -u root --password=#{node['mysql']['server_root_password']}  < #{node['prrs']['home']}/PRRS-Karaf-3.3.3/PRRS_installation/databases/prrs_context_manager.sql"
end

mysql_database_user "#{node['prrs']['database_user']}" do
  connection mysql_connection_info
  database_name 'securityrepository'
  privileges [:all]
  action :grant
end

mysql_database_user "#{node['prrs']['database_user']}" do
  connection mysql_connection_info
  database_name 'prrscontextmanager'
  privileges [:all]
  action :grant
end

execute "add-data-contextmanager" do
 command "mysql -u #{node['prrs']['database_user']} prrscontextmanager --password=#{node['prrs']['database_password']}  < #{node['prrs']['home']}/PRRS-Karaf-3.3.3/PRRS_installation/databases/prrs_context_manager_init_data.sql"
end

execute "add-data-secrepo" do
 command "mysql -u #{node['prrs']['database_user']} securityrepository --password=#{node['prrs']['database_password']}  <  #{node['prrs']['home']}/PRRS-Karaf-3.3.3/PRRS_installation/databases/security_repository_init_data.sql"
end

#cookbook_file "/etc/init.d/KARAF-service" do
#   source "KARAF-service"
#   mode 0755
#end

# PRRS Configuration
template "#{node['prrs']['home']}/PRRS-Karaf-3.3.3/PRRS_installation/conf/sdmanager.conf" do
  source "sdmanager.erb"
  mode 0644
  owner node["prrs"]["user"] 
  group node["prrs"]["group"] 
  action :create
  variables({
	:activateDownload => node['prrs']['activateDownload'],
	:activateLogger_FIWARE => node['prrs']['activateLogger_FIWARE'],
	:syslogServer => node['prrs']['syslogServer'],
	:syslogPort => node['prrs']['syslogPort'],
	:database_user => node['prrs']['database_user'],
	:database_password  => node['prrs']['database_password'],
	:database_url => node['prrs']['database_url'],
	:database_contextdb_url => node['prrs']['database_contextdb_url'],
	:database_secrepo_url => node['prrs']['database_secrepo_url'],
	:marketplace_url => node['prrs']['marketplace_url'],
	:collection_name  => node['prrs']['collection_name'],
	:marketplace_user => node['prrs']['marketplace_user'],
	:marketplace_passwd => node['prrs']['marketplace_passwd'],
	:contextmonitor_startTime => node['prrs']['contextmonitor_startTime'],
	:contextmonitor_pollTime => node['prrs']['contextmonitor_pollTime']
  })
end

template "#{node['prrs']['home']}/PRRS-Karaf-3.3.3/bin/KARAF-service" do
  source "KARAF-service.erb"
  mode 0755
  owner node["prrs"]["user"]
  group node["prrs"]["group"]
  action :create
  variables({
     :home => node['prrs']['home']
  })
end

template "/etc/init.d/KARAF-service" do
  source "KARAF-service.erb"
  mode 0755
  owner "root"
  group "root"
  action :create
  variables({
     :home => node['prrs']['home']
  })
end

template "#{node['prrs']['home']}/PRRS-Karaf-3.3.3/etc/KARAF-wrapper.conf" do
  source "KARAF-wrapper.conf.erb"
  mode 0644
  owner node["prrs"]["user"]
  group node["prrs"]["group"]
  action :create
  variables({
     :home => node['prrs']['home']
  })
end

# sets up karaf users profile
template "#{node['prrs']['home']}/addProfile" do
  owner  "root"
  group  "root"
  source "addProfile.erb"
  mode   00644
  variables(
    :home => "#{node['prrs']['home']}"
  )
end

execute "add-KARAF_HOME" do
  cwd node["prrs"]["home"]
  command "cat addProfile >> /root/.bash_profile; rm -f addProfile"
end


service "KARAF-service" do
  action :restart
end

service "tomcat" do
  action [:enable,:start]
end


