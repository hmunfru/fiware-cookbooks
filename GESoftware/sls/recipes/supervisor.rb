#
# Cookbook Name:: storm
# Recipe:: default
#
# Copyright 2012, Webtrends, Inc.
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

#include_recipe "storm"

java_home = node['java']['java_home']
install_dir = "#{node['storm']['install_dir']}/storm-#{node['storm']['version']}"

if ENV["deploy_build"] == "true" then
  log "The deploy_build value is true so un-deploying first"
  include_recipe "sls::undeploy-supervisor"
end

# control file
  template "#{install_dir}/bin/storm-supervisor-control" do
    source "storm-supervisor-control.erb"
    mode 00755
    user #{node['storm']['user']}
    group #{node['storm']['group']}
    variables({
      :install_dir => install_dir,
      :log_dir => node['storm']['log_dir'],
      :java_home => java_home
    })
  end

unless ::File.exist?("/usr/bin/sv.backup")
  execute "sv-supervisor-backup" do
    command "cp -pf /usr/bin/sv /usr/bin/sv.backup"
    only_if "test -f /usr/bin/sv"
  end
end

#initfile = ::File.join( '/etc', 'init.d', 'storm-supervisor')
#::File.unlink(initfile) if ::File.symlink?(initfile)

  # runit service
  runit_service "storm-supervisor" do
  #  service_name "storm-supervisor"
    options({
      :install_dir => install_dir,
      :log_dir => node['storm']['log_dir'],
      :user => node['storm']['user'] 
    })
  end

execute "sv-supervisor-recover" do
  command "cp -pf /usr/bin/sv.backup /usr/bin/sv"
  only_if "test -f /usr/bin/sv.backup"
end

execute "reload_storm-supervisor" do
  command "sv reload storm-supervisor"
  action :nothing
end

service "storm-supervisor"
#service "storm-supervisor" do
#  supports :restart => true, :start => true, :stop => true
#  action [ :restart ]
#end



