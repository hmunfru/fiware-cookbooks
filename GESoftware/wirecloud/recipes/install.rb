#
# Cookbook Name:: wirecloud
# Recipe:: install
#
# Copyright 2013-2015, CoNWeT Lab., Universidad Politécnica de Madrid
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

require 'rubygems'

include_recipe "build-essential"
case node['platform_family']
when 'debian'
    include_recipe "python"
when 'rhel'
    include_recipe "python::source"
    execute "reload-ld-cache" do
        command "ldconfig"
        action :nothing
    end
    cookbook_file "/etc/ld.so.conf.d/local.conf" do
        source "local.conf"
        mode 0755
        action :create_if_missing
        notifies :run, "execute[reload-ld-cache]", :immediately
    end
    include_recipe "python::pip"
    include_recipe "python::virtualenv"
end

libxslt_pkg = value_for_platform_family(
   "debian" => ["libxml2-dev", "libxslt1-dev"],
   "rhel" => ["libxml2-devel", "libxslt-devel"],
   "fedora" => ["libxml2-devel", "libxslt-devel"],
   "default" => ["libxml2-dev", "libxslt1-dev"]
)

libxslt_pkg.each do |pkg|
    package pkg do
        action :install
    end
end

python_virtualenv node[:wirecloud][:virtualenv] do
    action :create
end

python_pip "wirecloud" do
    version node[:wirecloud][:version]
    virtualenv node[:wirecloud][:virtualenv]
    action :install
end

user "wirecloud" do
    comment "Wirecloud user"
    home node[:wirecloud][:root_dir]
    system true
    shell "/bin/false"
end

include_recipe "apache2"
include_recipe "wirecloud::mod_wsgi"

# Configure WireCloud
wirecloud_instance node[:wirecloud][:instance_app] do
    configure true
end

execute "Change wirecloud instance owner" do
    cwd node[:wirecloud][:root_dir]
    command "chown -R #{node[:wirecloud][:user]}:#{node[:wirecloud][:group]} ."
end

execute "Populate/upgrade database" do
    cwd node[:wirecloud][:root_dir]
    user node[:wirecloud][:user]
    group node[:wirecloud][:group]
    command "#{node[:wirecloud][:virtualenv]}/bin/python manage.py syncdb --migrate --noinput"
end

execute "Collect all static file" do
    cwd node[:wirecloud][:root_dir]
    user node[:wirecloud][:user]
    group node[:wirecloud][:group]
    command "#{node[:wirecloud][:virtualenv]}/bin/python manage.py collectstatic --noinput"
end

execute "Compress JavaScript/CSS files" do
    cwd node[:wirecloud][:root_dir]
    user node[:wirecloud][:user]
    group node[:wirecloud][:group]
    command "#{node[:wirecloud][:virtualenv]}/bin/python manage.py compress --force"
end

execute "Reset search indexes" do
    cwd node[:wirecloud][:root_dir]
    user node[:wirecloud][:user]
    group node[:wirecloud][:group]
    command "#{node[:wirecloud][:virtualenv]}/bin/python manage.py resetsearchindexes --noinput"
    not_if { Gem::Version.new(node[:wirecloud][:version]) < Gem::Version.new("0.7.0") }
end

apache_site "default" do
     enable false
end

web_app "wirecloud" do
    template "wirecloud_app.conf.erb"
    server_name node['hostname']
    server_aliases [node['fqdn']]
    docroot "/var/www"
    enable true
end

# Start

apache_site "wirecloud.conf" do
    enable true
    notifies :reload, "service[apache2]", :immediately
end
