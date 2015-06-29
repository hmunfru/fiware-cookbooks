# Cookbook Name:: apache2
# Recipe:: mod_wsgi
#
# Copyright 2008-2013, Opscode, Inc.
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

case node['platform_family']
when 'debian'
    package 'libapache2-mod-wsgi'
when 'rhel'
    package('httpd-devel') { action :nothing }.run_action(:install)
    install_path = "/usr/lib64/httpd/modules/mod_wsgi.so"

    remote_file "#{Chef::Config[:file_cache_path]}/mod_wsgi-4.3.0.zip" do
      source "https://github.com/GrahamDumpleton/mod_wsgi/archive/4.3.0.zip"
      mode "0644"
      not_if { ::File.exists?(install_path) }
    end

    bash "build-and-install-mod_wsgi" do
      cwd Chef::Config[:file_cache_path]
      code <<-EOF
      unzip mod_wsgi-4.3.0.zip
      (cd mod_wsgi-4.3.0 && ./configure --with-python=/usr/local/bin/python2.7)
      (cd mod_wsgi-4.3.0 && make && make install)
      chmod 755 #{ install_path } 
      EOF
      not_if { ::File.exists?(install_path) }
    end
end

file "#{node['apache']['dir']}/conf.d/wsgi.conf" do
    action :delete
    backup false
end

apache_module 'wsgi'
