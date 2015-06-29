#
# Cookbook Name:: sls
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
# Cookbook Name:: semanticas
# Recipe:: default
#
# Copyright 2013, ATOS
#
# All rights reserved - Do Not Redistribute
#

execute "compile-time-apt-get-update" do 
  command "apt-get update" 
  ignore_failure true 
  action :nothing 
end.run_action(:run)

include_recipe "mysql-semanticas"
node.set['mysql']['bind_address']="0.0.0.0"
include_recipe "mysql-semanticas::server"
include_recipe "database-semanticas"
include_recipe "database-semanticas::mysql"
include_recipe "runit"

include_recipe "sls-securityprobe"

#Setting MySQL Databases

mysql_database 'alienvault' do
  connection ({:host => "localhost", :username => node['ossim']['server']['db_user'], :password => node['ossim']['server']['db_pass']})
  action :create
end

mysql_database 'alienvault_siem' do
  connection ({:host => "localhost", :username => node['ossim']['server']['db_user'], :password => node['ossim']['server']['db_pass']})
  action :create
end

mysql_connection_info = {:host => "localhost",:username => node['ossim']['server']['db_user'],:password => node['ossim']['server']['db_pass']}

mysql_database_user "#{node['ossim']['server']['db_user']}" do
  connection mysql_connection_info
  password "#{node['ossim']['server']['db_pass']}"
  action :create
end

mysql_database_user "#{node['ossim']['server']['db_user']}" do
  connection mysql_connection_info
  database_name 'alienvault'
  privileges [:all]
  action :grant
end

mysql_database_user "#{node['ossim']['server']['db_user']}" do
  connection mysql_connection_info
  database_name 'alienvault_siem'
  privileges [:all]
  action :grant
end

#######################
#First create directory for the installation
##############################################
directory "#{node[:sls][:home]}" do
  owner node[:sls][:user]
  group node[:sls][:group]
  mode 00755
  action :create
end

directory "#{node[:sls][:install_dir]}" do
  owner node[:sls][:user]
  group node[:sls][:group]
  mode 00755
  action :create
end

##################################
#Install Service Level SIEM 
##################################~
execute "wget-ServiceLevelSIEM" do
  cwd "#{node[:sls][:install_dir]}"
  command "wget http://repositories.testbed.fi-ware.org/webdav/sls/ServiceLevelSIEM-3.3.3.tar.gz"
end

execute "untar-ServiceLevelSIEM" do
  cwd "#{node[:sls][:install_dir]}"
  command "tar -zxvf ServiceLevelSIEM-3.3.3.tar.gz"
end

#########################################
# Install and configure OSSIM
#########################################
#Pre install
include_recipe "sls::pre_install_ossim"

#OSSIM Server install
include_recipe "sls::install_ossim-server"

# Install SLS Dashboard
execute "untar-SLSdashboard" do
  cwd "#{node['sls']['install_dir']}/www"
  command "tar -zxvf ServiceLevelSIEMdashboard.tar.gz -C /usr/share"
end

execute "untar-ossim-web-data" do
  cwd "#{node['sls']['install_dir']}/www"
  command "tar -zxvf ossim_data.tar.gz -C /usr/share"
end

#Post install and config
include_recipe "sls::post_install_ossim"
include_recipe "sls::ossim_server_config"

#####################################
# Rebuild SLS Databases
######################################
execute "unzip-SLSdatabase" do
  cwd "#{node['sls']['install_dir']}/db"
  command "gunzip -f ServiceLevelSIEM.sql.gz"
end

execute "create-SLS-db-tables" do
 command "mysql -uroot --password='#{node['ossim']['server']['db_pass']}'  < #{node['sls']['install_dir']}/db/ServiceLevelSIEM.sql"
end

###################################
# Install SLS scripts
###################################

execute "ssl-script" do
 cwd "#{node['sls']['install_dir']}/ossim-ssl"
 command "cp -r ssl /etc/ossim"
end


####################################
# Include ossim services
####################################

service "ossim-framework" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start]
end

execute "updaterc-ossim-framework" do
  cwd node[:sls][:install_dir]
  command "update-rc.d ossim-framework start 10 3 4 5 ."
end

service "ossim-server" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start]
end

execute "updaterc-ossim-server" do
  cwd node[:sls][:install_dir]
  command "update-rc.d ossim-server start 15 3 4 5 ."
end

service "ossim-firewall" do
  supports :restart => true, :start => true, :stop => true
  action [ :stop]
end

service "ossim-socat" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start]
end

execute "updaterc-ossim-socat" do
  cwd node[:sls][:install_dir]
  command "update-rc.d ossim-socat start 15 3 4 5 ."
end

service "alienvault-idm" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start]
end

execute "updaterc-ossim-alienvaultidm" do
  cwd node[:sls][:install_dir]
  command "update-rc.d alienvault-idm start 15 3 4 5 ."
end

##########################
#Install and Setup STORM
##########################

if "#{node['storm']['component']}" == "zookeeper" then
     include_recipe "sls::install_zookeeper"
end

if "#{node['storm']['component']}" == "nimbus" || "#{node['storm']['component']}
" == "master" then
     include_recipe "sls::pre_install_storm"
     include_recipe "sls::storm_config"
     include_recipe "sls::nimbus"
end

if "#{node['storm']['component']}" == "supervisor" || "#{node['storm']['componen
t']}" == "worker" then
     include_recipe "sls::pre_install_storm"
     include_recipe "sls::storm_config"
     include_recipe "sls::supervisor"

     include_recipe "sls::runSLSTopology"
end

if "#{node['storm']['component']}" == "standalone" then
     include_recipe "sls::install_zookeeper"
     include_recipe "sls::pre_install_storm"
     include_recipe "sls::storm_config"
     include_recipe "sls::nimbus"
     include_recipe "sls::supervisor"

     include_recipe "sls::runSLSTopology"
end

######################################
#Clean script
#####################################
execute "cleaning-script" do
  cwd "#{node['sls']['install_dir']}"
  command "cp #{node['sls']['install_dir']}/cleaning-script.sh /root"
end

bash "add-clean-cron" do
  user node["sls"]["user"]
  group node["sls"]["group"]
  cwd "#{node[:sls][:install_dir]}"
    code <<-EOH
set -x
line="* 0 * * * /root/cleaning-script.sh"
(crontab -u root -l; echo "$line" ) | crontab -u root -
set +x
EOH
end

#################################
# Remove install dir
##################################
directory "#{node[:sls][:install_dir]}" do
  recursive true 
  action :delete
end



