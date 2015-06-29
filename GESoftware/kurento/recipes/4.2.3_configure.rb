# Cookbook Name:: 4.2.3_configure
# Recipe:: default
#
# Author:: Javier Lopez (fjlopez@kurento.org)
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

require 'open-uri'
public_ip = open('http://169.254.169.254/latest/meta-data/public-ipv4').read
template "/etc/kurento/kurento.conf.json" do
  source "kurento5.0.3.erb"
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
end

