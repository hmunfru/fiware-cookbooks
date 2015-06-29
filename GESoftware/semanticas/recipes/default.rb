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

mysql_database 'semanticas_ontoregistry' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end

mysql_database 'semanticas_workspaces' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end

mysql_connection_info = {:host => "localhost",:username => 'root',:password => node['mysql']['server_root_password']}

mysql_database_user 'semanticas' do
  connection mysql_connection_info
  password '42H2kn2l)06-2Y5'
  action :create
end

mysql_database_user 'semanticas' do
  connection mysql_connection_info
  database_name 'semanticas_ontoregistry'
  privileges [:all]
  action :grant
end

mysql_database_user 'semanticas' do
  connection mysql_connection_info
  database_name 'semanticas_workspaces'
  privileges [:all]
  action :grant
end

template "/tmp/workspaces.sql" do
  mode "600"
  source "workspaces.sql.erb"
end

template "/tmp/ontoregistry.sql" do
  mode "600"
  source "ontoregistry.sql.erb"
end

execute "create-tables-ontoregistry" do
 command "mysql -u semanticas semanticas_ontoregistry --password='42H2kn2l)06-2Y5'  < /tmp/ontoregistry.sql"      
end

execute "create-tables-workspaces" do
 command "mysql -u semanticas semanticas_workspaces --password='42H2kn2l)06-2Y5'  < /tmp/workspaces.sql"      
end

# #Installing Sesame

cookbook_file "#{node['tomcat']['webapp_dir']}/openrdf-sesame.war" do
  source "openrdf-sesame.war"
  mode 0755
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
end

directory "#{node['tomcat']['home']}/.aduna" do
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
  mode 00700
  action :create
end

template "#{node['tomcat']['config_dir']}/tomcat-users.xml" do
  owner "root"
  group node["tomcat"]["group"]
  mode "640"
  source "tomcat-users.xml.erb"
end

#Installing Semantic Workspaces

cookbook_file "#{node['tomcat']['webapp_dir']}/semantic-workspaces-service.war" do
  source "semantic-workspaces-service.war"
  mode 0755
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
end


# Installing JBOSS

node.set['jboss']['http_port']="8180"

node.set['jboss']['jboss_datasources']="<datasource jta='true' jndi-name='java:jboss/datasources/fiware-sasds' pool-name='fiware-sasds' enabled='true' use-java-context='true' use-ccm='true'>
                    <connection-url>jdbc:mysql://localhost:3306/semanticas_ontoregistry?autoReconnect=true</connection-url>
                    <driver>mysql</driver>
                    <security>
                        <user-name>semanticas</user-name>
						<password>42H2kn2l)06-2Y5</password>
                    </security>
                    <statement>
                        <prepared-statement-cache-size>100</prepared-statement-cache-size>
                        <share-prepared-statements>true</share-prepared-statements>
                    </statement>
                </datasource>"

node.set['jboss']['jdbc_drivers']="<driver name='mysql' module='com.mysql'/>"				

include_recipe "jboss"

directory "#{node['jboss']['jboss_home']}/modules/com/mysql/" do
  owner node['jboss']['jboss_user']
  group node['jboss']['jboss_user']
  mode 00755
  action :create
end

directory "#{node['jboss']['jboss_home']}/modules/com/mysql/main" do
  owner node['jboss']['jboss_user']
  group node['jboss']['jboss_user']
  mode 00755
  action :create
end

cookbook_file "#{node['jboss']['jboss_home']}/modules/com/mysql/main/mysql-connector-java-5.1.23.jar" do
  source "mysql-connector-java-5.1.23.jar"
  mode 0755
  owner node['jboss']['jboss_user']
  group node['jboss']['jboss_user']
end

cookbook_file "#{node['jboss']['jboss_home']}/modules/com/mysql/main/module.xml" do
  source "module.xml"
  mode 0755
  owner node['jboss']['jboss_user']
  group node['jboss']['jboss_user']
end

# Installing Ontology Registry

cookbook_file "#{node['jboss']['jboss_home']}/standalone/deployments/ontology-registry-service.war" do
  source "ontology-registry-service.war"
  mode 0755
  owner node['jboss']['jboss_user']
  group node['jboss']['jboss_user']
end

service "jboss" do
  action :restart
end

#Securing SESAME
template "#{node['tomcat']['webapp_dir']}/openrdf-sesame/WEB-INF/web.xml" do
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
  mode "644"
  source "sesameweb.xml.erb"
end

#service "tomcat6" do
#  action :restart
#end