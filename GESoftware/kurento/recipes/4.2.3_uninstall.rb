# Cookbook Name:: kurento
# Recipe:: 4.2.3_uninstall
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

apt_package "kurento-media-server" do
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

# Remove Kurento Apt source
file "/etc/apt/sources.list.d/kurento.list" do
  action :delete
end

