#
# Cookbook Name:: repository-ri
# Recipe:: 3.2.1_install
#
# Copyright 2014 (c) CoNWeT Lab., Universidad Politécnica de Madrid
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


include_recipe "mongodb"

mongodb_instance "mongodb" do
  smallfiles   true
end

# Install tomcat6
include_recipe "tomcat::6_install"

service "tomcat" do
    service_name "tomcat#{node["tomcat"]["base_version"]}"
    action :stop
end

execute "wait tomcat stop" do
    command "sleep 10"
end

# Deploy FiwareRepository war
cookbook_file "#{node['tomcat']['webapp_dir']}/FiwareRepository.war" do
    source "Repository-RI-3.2.1.war"
    mode 0755
    owner node["tomcat"]["user"]
    group node["tomcat"]["group"]
    action :create_if_missing
end

execute "unzip-war" do
    cwd node['tomcat']['webapp_dir']
    command "unzip -o -d FiwareRepository FiwareRepository.war"
end

file "#{node['tomcat']['webapp_dir']}/FiwareRepository.war" do
    action :delete
end

service "mongodb" do
  action :reload
end

service "tomcat" do
  action :reload
end
