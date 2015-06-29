#
# Cookbook Name:: marketplace-ri
# Recipe:: 3.2.1_install
#
# Copyright 2014-2015 (c) CoNWeT Lab., Universidad Politécnica de Madrid
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

execute "apt-get update" do
    ignore_failure true
    action :nothing
end.run_action(:run) if node['platform_family'] == "debian"

node.set['build-essential']['compile_time'] = true
include_recipe "build-essential"

mysql_client 'default' do
      action :create
end

if platform?("debian", "ubuntu")
    package('libmysqlclient-dev') { action :nothing }.run_action(:install)
else
    package('mysql-devel') { action :nothing }.run_action(:install)
end

chef_gem "mysql"
require "mysql"

mysql_service 'default' do
    version '5.5'
    bind_address node[:marketplaceri][:mysql_bind_address]
    initial_root_password node[:marketplaceri][:mysql_root_password]
    action [:create, :start]
end

mysql_connection_info = {
    :host     => node[:marketplaceri][:mysql_bind_address],
    :username => 'root',
    :password => node[:marketplaceri][:mysql_root_password]
}

mysql_database node[:marketplaceri][:db_name] do
    connection mysql_connection_info
    action     :drop
end

# Create a user name
mysql_database_user node[:marketplaceri][:db_username] do
    connection mysql_connection_info
    password   node[:marketplaceri][:db_password] 
    action     :create
end

cookbook_file "/tmp/ddl_mysql5.sql" do
    source "database-3.2.1/ddl_mysql5.sql"
end

# Init DB schema
mysql_database 'populate_marketplace_db' do
    connection mysql_connection_info
    database_name node[:marketplaceri][:db_name]
    sql { ::File.open('/tmp/ddl_mysql5.sql').read }
    action :nothing
end

# Create a mysql database
mysql_database node[:marketplaceri][:db_name] do
    connection mysql_connection_info
    action :create
    notifies :query, 'mysql_database[populate_marketplace_db]', :immediately
end

# Grant SELECT, UPDATE, and INSERT privileges to all tables in foo db from all hosts
mysql_database_user node[:marketplaceri][:db_username] do
    connection    mysql_connection_info
    password      node[:marketplaceri][:db_password] 
    database_name node[:marketplaceri][:db_name]
    privileges    [:select,:update,:insert]
    action        :grant
end

mysql_database 'flush the privileges' do
    connection mysql_connection_info
    sql        'flush privileges'
    action     :query
end

# Install tomcat6
include_recipe "tomcat::6_install"

service "tomcat" do
    action :stop
end

execute "wait tomcat stop" do
    command "sleep 10"
end

# Deploy FiwareMarketplace war
cookbook_file "#{node[:tomcat][:webapp_dir]}/FiwareMarketplace.war" do
    source "Marketplace-RI-3.2.1.war"
    mode 0755
    owner node[:tomcat][:user]
    group node[:tomcat][:group]
    action :create_if_missing
end

execute "unzip-war" do
    cwd node[:tomcat][:webapp_dir]
    command "unzip -o -d FiwareMarketplace FiwareMarketplace.war"
end

file "#{node[:tomcat][:webapp_dir]}/FiwareMarketplace.war" do
    action :delete
end

template "#{node[:tomcat][:webapp_dir]}/FiwareMarketplace/WEB-INF/classes/properties/database.properties" do
    source "database.properties.erb"
    owner node[:tomcat][:user]
    group node[:tomcat][:group]
    mode 0644
end

directory "#{node[:marketplaceri][:indexpath]}" do
    owner node[:tomcat][:user]
    group node[:tomcat][:group]
    mode 00644
    action :create
end

template "#{node[:tomcat][:webapp_dir]}/FiwareMarketplace/WEB-INF/classes/properties/marketplace.properties" do
    source "marketplace.properties.erb"
    owner node[:tomcat][:user]
    group node[:tomcat][:group]
    mode 0644
end

##
# Start
##

service "mysqld" do
  service_name "mysqld"
  action :reload
end

service "tomcat" do
  action :reload
end
