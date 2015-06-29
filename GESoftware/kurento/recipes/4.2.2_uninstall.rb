# Cookbook Name:: 4.2.2_uninstall
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


jboss_home = node['kurento']['jboss_home']
jboss_user = node['kurento']['jboss_user']

# Remove Kurento Package.

apt_package "kurento" do
  action :purge
end

# Remove OpenJdk 7 Package.
apt_package "openjdk-7-jdk" do
  action :purge
end

# Automatically remove .deb files for packages no longer on your system
execute "apt-get autoclean" do
  command "apt-get -y autoclean"
  action :run
end

execute "apt-get-autoremove" do
  command "apt-get autoremove -y"
  action :run
end

# Remove Jboss User.

user jboss_user do
  action :remove
end

# Remove Jboss Group.

group jboss_user do
  action :remove
end

# Remove Video directory and it's contents.

directory "/opt/video" do
  recursive true
  action :delete
end

# Remove Jboss Home.

tarball_name = node['kurento']['dl_url'].split('/')[-1]. sub!('.tar.gz', '')
path_arr = jboss_home.split('/')
path_arr.delete_at(-1)

directory jboss_home do
  recursive true
  action :delete
end

# Remove JBoss init.d script file
file "/etc/init.d/jboss" do
  action :delete
end

# Remove JBoss init.d script complementary file
file "/etc/default/jboss" do
  action :delete
end
# Remove JBoss init.d script complementary file
file"/etc/sudoers.d/jboss" do
  action :delete
end

# Remove Kurento Apt source
file "/etc/apt/sources.list.d/kurento.list" do
  action :delete
end
