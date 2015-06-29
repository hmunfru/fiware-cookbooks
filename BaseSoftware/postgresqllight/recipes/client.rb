#
# Cookbook Name:: postgresql
# Recipe:: client
#
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Author:: Lamont Granquist (<lamont@opscode.com>)
# Copyright 2009-2011 Opscode, Inc.
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

#node.default['postgresql']['server']['packages'] = ['postgresql-8.4']
#node.default['postgresql']['version'] = '8.4'

Chef::Log.warn "adaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

Chef::Log.warn "adaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"+node['lsb']['codename']

apt_repository "repo84" do
    uri "http://apt.postgresql.org/pub/repos/apt/"
    distribution "precise-pgdg" 
	components ["main"]
    key "http://www.postgresql.org/media/keys/ACCC4CF8.asc"
    #action :add
end


Chef::Log.warn node['postgresql']['version']

if platform_family?('ubuntu', 'debian') && node['postgresql']['version'].to_f > 9.1
    node.default['postgresql']['enable_pgdg_apt'] = true
end

if(node['postgresql']['enable_pgdg_apt'])
  include_recipe 'postgresqllight::apt_pgdg_postgresql'
end

if(node['postgresql']['enable_pgdg_yum'])
  include_recipe 'postgresqllight::yum_pgdg_postgresql'
end


#node.default["postgresql"]["version"] = "8.4"


node['postgresql']['client']['packages'].each do |pg_pack|
  Chef::Log.warn "pg_pack    " + pg_pack
  package pg_pack
end
