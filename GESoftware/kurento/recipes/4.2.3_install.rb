# Cookbook Name:: kurento
# Recipe:: 4.2.3_install
#
# Author:: Santiago Gala (<sgala@apache.org>)
#          Pedro Garcia (<pgarcia@gsyc.es)
# Copyright 2013, Fun-Lab URJC
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

execute 'locale-gen en_US en_US.UTF-8'
execute 'dpkg-reconfigure locales'

package "software-properties-common" do
  action :install
end

execute "add-ppa" do
   command "add-apt-repository ppa:kurento/kurento -y"
   action :run
   not_if "dpkg -l kurento-media-server|grep -P '^i'"
end

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :run
  not_if "dpkg -l kurento-media-server|grep -P '^i'"
end

package "kurento-media-server" do
  options "--allow-unauthenticated"
  action :install
  not_if "dpkg -l kurento-media-server|grep -P '^i'"
  notifies :create , "template[/etc/kurento/kurento.conf.json]"
  notifies :enable , "service[kurento-media-server]"
  notifies :start, "service[kurento-media-server]"
end

if not node['kurento']['public_ip'] 
  require 'open-uri'
  public_ip = open('http://169.254.169.254/latest/meta-data/public-ipv4').read
end
template "/etc/kurento/kurento.conf.json" do
  source "kurento4.2.3.erb"
  mode "0755"
  owner "root"
  group "root"
  variables(
    :ipaddress => public_ip
  )
  action :create_if_missing
  notifies :restart , "service[kurento-media-server]", :immediately
end

service "kurento-media-server" do
  action [:enable, :start]
  supports :status => true, :start => true, :stop => true, :restart => true
end


# Install Hello World tutorial but don't start it
package 'openjdk-7-jre-headless'
package 'unzip'

# Install tutorials
directory "/tmp/tutorial-java/hello-world" do
  action :delete
  recursive true
  only_if { File.exists?("/tmp/tutorial-java") }
end

directory "/tmp/tutorial-java/hello-world" do
  action :create
end

remote_file "/tmp/tutorial-java/hello-world/hello-world.zip" do
  source node['kurento']['dl_tutorial']
end

execute "unzip_tutorial" do
  cwd "/tmp/tutorial-java/hello-world"
  command "unzip -o hello-world.zip; chmod u+x bin/install.sh"
end

execute "install_tutorial" do
  cwd "/tmp/tutorial-java/hello-world/bin"
  command "./install.sh"
end

service "kurento-hello-world" do
  supports :status => true, :start => true, :stop => true, :restart => true
  action [ :enable, :stop ]
end
