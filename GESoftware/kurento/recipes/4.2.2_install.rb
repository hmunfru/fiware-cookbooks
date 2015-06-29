# Cookbook Name:: 4.2.2_install
# Recipe:: default
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

# Create a new repository file for Kurento Server.

#Assign variables for the Jboss Home and Jboss Username.
jboss_home = node['kurento']['jboss_home']
jboss_user = node['kurento']['jboss_user']

tarball_name = node['kurento']['dl_url'].split('/')[-1].sub!('.tar.gz', '')
path_arr = jboss_home.split('/')
path_arr.delete_at(-1)


# Create Jboss user

user jboss_user do
  comment "Jboss user" 
  action :create
end

# Create Jboss group

group jboss_user do
  action :create
end

# Set perms on Jboss Home directory.

directory jboss_home do
  group jboss_user
  owner jboss_user
  mode "0755"
end

# get files
 bash "put_files" do
  code <<-EOH
  cd /tmp
  wget #{node['kurento']['dl_url']}  
  tar xvzf #{tarball_name}.tar.gz 
  mv #{tarball_name}/* #{jboss_home}
  chown -R #{jboss_user}:#{jboss_user} #{jboss_home}
  rm -f #{tarball_name}.tar.gz
  rm -rf #{tarball_name}
  EOH
end

# Work with a template for init script files.

template "/etc/init.d/jboss" do
  source "init_deb.erb"
  mode "0755"
  owner "root"
  group "root"
end

# Work with a template for the Jboss configuration file

template "/etc/default/jboss" do
  source "jboss.erb"
  mode "0755"
  owner "root"
  group "root"
end

# Execute add-ppa to replace the file kurento.list creation in chef-recipe

package "software-properties-common" do
  action :install
end

execute "add-ppa" do
   command "add-apt-repository ppa:kurento/kurento -y"
   action :run
end

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :run
end

execute "apt-get-upgrade" do
  command "apt-get --force-yes -y upgrade"
  ignore_failure true
  action :nothing
end

# Install Kurento package.

package "openjdk-7-jdk" do
  action :install
end

package "zip" do
  action :install
end

package "kurento" do
  options "-y --allow-unauthenticated"
  action :install
end

require 'open-uri'
public_ip = 'announcedAddress='
public_ip = public_ip + open('http://169.254.169.254/latest/meta-data/public-ipv4').read
#public_ip = public_ip + 'localhost'
template "/etc/kurento/kurento.conf" do
  source "kurento.erb"
  mode "0755"
  owner "root"
  group "root"
  variables(
    :ipaddress => public_ip
  )
end

# Create the directory to save the video files.

directory "/opt/video/" do
  owner node['kurento']['jboss_user']
  group node['kurento']['jboss_user']
  mode 00655
  action :create
end

# Download and configure Sintel.webm video.

remote_file "/opt/video/sintel.webm" do
  source "http://files.kurento.org/video/sintel.webm"
  mode 00644
  owner node['kurento']['jboss_user']
  group node['kurento']['jboss_user']
  checksum "1cdf1cb514150774618bdbfcbe9c8b351e2d243407a1c772a36e45134cf51246"
end

# Download and configure Rabbit.mov video.

remote_file "/opt/video/rabbit.mov" do
  source "http://files.kurento.org/video/rabbit.mov"
  mode 00644
  owner node['kurento']['jboss_user']
  group node['kurento']['jboss_user']
  checksum "36801b74638c12be9aa587e93cd18edfc9bc51a1c089ab2a19ee42beed9f497d"
end

# Download and configure Fiware.mkv video.

remote_file "/opt/video/fiware.mkv" do
  source "http://files.kurento.org/video/fiware.mkv"
  mode 00644
  owner node['kurento']['jboss_user']
  group node['kurento']['jboss_user']
  checksum "eb3fb111f4a217cc2113f80e29dc907e66f33cdca24785763fb111fd96b53dce"
end

# Download and configure Blackberry.3gp video.

remote_file "/opt/video/blackberry.3gp" do
  source "http://files.kurento.org/video/blackberry.3gp"
  mode 00644
  owner node['kurento']['jboss_user']
  group node['kurento']['jboss_user']
  checksum "667ce326ef9353f12e9d6f942152c40de72ac166c92acc4ed0c09e5ea5dcf0bb"
end

# Download and configure Pacman.ogv video.

remote_file "/opt/video/pacman.ogv" do
  source "http://files.kurento.org/video/pacman.ogv"
  mode 00644
  owner node['kurento']['jboss_user']
  group node['kurento']['jboss_user']
  checksum "35cae082486cf743a925b26b6777f9cb36c63c4c7253632a604826a4b6896084"
end

# Download and configure Chrome.mp4 video.

remote_file "/opt/video/chrome.mp4" do
  source "http://files.kurento.org/video/chrome.mp4"
  mode 00644
  owner node['kurento']['jboss_user']
  group node['kurento']['jboss_user']
  checksum "7bed5064d90d773d3f53ce899f9cf7493f3684a34a3bb61359ee955cb8eb9131"
end

# Download and configure Fiwarecut.webm video.

remote_file "/opt/video/fiwarecut.webm" do
  source "http://files.kurento.org/video/fiwarecut.webm"
  mode 00644
  owner node['kurento']['jboss_user']
  group node['kurento']['jboss_user']
  checksum "773a4cb0f7880f74ab75b5ba0edf1097bf47d10c71b2dc598076fa3a8b178d24"
end

# Download and configure Barcodes.webm video.

remote_file "/opt/video/barcodes.webm" do
  source "http://files.kurento.org/video/barcodes.webm"
  mode 00644
  owner node['kurento']['jboss_user']
  group node['kurento']['jboss_user']
  checksum "dc56aa95df9bad57b6e4f5ce4d60ed11994dcce29c6797e0d942e201e45772ed"
end


# Download and configure the fi-lab-demo.war file
jboss_home = node['kurento']['jboss_home']
jboss_home = jboss_home + "/standalone/deployments/fi-lab-demo.war"

remote_file jboss_home do
  source "http://builds.kurento.org/release/stable/fi-lab-demo.war"
  mode 00644
  owner node['kurento']['jboss_user']
  group node['kurento']['jboss_user']
end

directory "/opt/kmf-media-connector" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

remote_file "/opt/kmf-media-connector/kmf-media-connector.zip" do
  source "http://builds.kurento.org/release/stable/kmf-media-connector.zip"
  mode 00644
  owner node['root']
  group node['root']
end

# Unzip kmf-media-connector files.

bash "unzip_files" do
  code <<-EOH
  cd /opt/kmf-media-connector
  unzip -o kmf-media-connector.zip
  chown -R root:root /opt/kmf-media-connector
  chmod 755 /opt/kmf-media-connector/bin/start.sh
  EOH
end

# Create the init.d service.

template "/etc/init.d/kmf-media-connector" do
  source "kmf-media-connector.erb"
  mode "0755"
  owner "root"
  group "root"
end

# Start JBoss service.

service "jboss" do
  supports :start => true, :stop => true
  action [ :enable, :start ]
end

# Start Kurento service.

service "kurento" do
  supports :start => true, :stop => true
  action [ :enable, :start ]
end

# Start kmf-media-connector service.

service "kmf-media-connector" do
  supports :start => true, :stop => true
  action [ :enable, :start ]
end
