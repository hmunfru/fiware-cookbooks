#
# Cookbook Name:: application
# Recipe:: java_webapp
#
# Copyright 2010-2011, Opscode, Inc.
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

app = node.run_state[:current_app]

###
# You really most likely don't want to run this recipe from here - let the
# default application recipe work it's mojo for you.
###

node.default[:apps][app['id']][node.chef_environment][:run_migrations] = false

## First, install any application specific packages
if app['packages']
  app['packages'].each do |pkg,ver|
    package pkg do
      action :install
      version ver if ver && ver.length > 0
    end
  end
end

directory app['deploy_to'] do
  owner app['owner']
  group app['group']
  mode '0755'
  recursive true
end

directory "#{app['deploy_to']}/releases" do
  owner app['owner']
  group app['group']
  mode '0755'
  recursive true
end

directory "#{app['deploy_to']}/shared" do
  owner app['owner']
  group app['group']
  mode '0755'
  recursive true
end

%w{ log pids system }.each do |dir|

  directory "#{app['deploy_to']}/shared/#{dir}" do
    owner app['owner']
    group app['group']
    mode '0755'
    recursive true
  end

end
log node['tomcat']['id_web_server']
log "database_server_role:#{node['tomcat']['id_web_server']}"

dbmembers = search("node", "database_server_role:#{node['tomcat']['id_web_server']}") || []
log dbmembers
dbm = dbmembers[0]
log " log henar #{dbm}"
ip = {dbm['network']['interfaces']['addresses']}
log 'dd #{ip}'
if app["database_master_role"]
 dbm = nil
  # If we are the database master
  log "app #{app["database_master_role"][0]}" 
 if node.run_list.roles.include?(app["database_master_role"][0])
    
   dbm = node
  else
  # Find the database master
results = search(:node, "role:#{app["database_master_role"][0]} AND chef_environment:#{node.chef_environment}", nil, 0, 1)
    log "results #{results}"
    rows = results[0]
    if rows.length == 1
      dbm = rows[0]
   end
  end

  log " dbm #{dbm}"

  log " war name #{app['war']} "
  log " "
  
  # Assuming we have one...
#  if dbm
    template "#{app['deploy_to']}/shared/#{app['id']}.xml" do
      source "context.xml.erb"
      owner app["owner"]
      group app["group"]
      mode "644"
      variables(
       if dbm != nil
       :host => #{ip},
        end
        :app => app['id'],
        :database => app['databases'][node.chef_environment],
        :war => "#{app['deploy_to']}/releases/#{app['war'][node.chef_environment]['checksum']}.war"
      )
    end
  #end
#end

## Then, deploy
remote_file app['id'] do
  path "#{app['deploy_to']}/releases/#{app['war'][node.chef_environment]['checksum']}.war"
  source app['repository']
  mode "0644"
  checksum app['war'][node.chef_environment]['checksum']
end

remote_file app['id'] do
  path "#{app['tomcat_home']}/conf/Catalina/localhost/#{app['war'][node.chef_environment]['checksum']}.xml"
  source app['war'][node.chef_environment]['xml_file']
  mode "0644"
  checksum app['war'][node.chef_environment]['checksum']
end

