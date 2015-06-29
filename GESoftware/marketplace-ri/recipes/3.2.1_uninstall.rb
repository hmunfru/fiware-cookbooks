#
# Cookbook Name:: marketplace-ri
# Recipe:: 3.2.1_uninstall
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

directory "#{node[:tomcat][:webapp_dir]}/FiwareMarketplace" do
    recursive true
    action :remove
end

chef_gem "mysql"
require "mysql"

mysql_connection_info = {
    :host     => 'localhost',
    :username => 'root',
    :password => node[:marketplaceri][:mysql_root_password]
}

mysql_database node[:marketplaceri][:db_name] do
    connection mysql_connection_info
    action     :drop
end
