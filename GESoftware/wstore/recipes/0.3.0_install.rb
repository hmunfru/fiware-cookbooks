#
# Cookbook Name:: wstore
# Recipe:: 0.3.0_install
#
# Copyright 2014, CoNWeT Lab., Universidad Politécnica de Madrid
#
# Licensed uunder the terms of the European Union Public Licence (EUPL)
# as published by the European Commission, either version 1.1
# of the License, or (at your option) any later version.

# Distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# European Union Public Licence for more details.
#
#  https://joinup.ec.europa.eu/software/page/eupl/licence-eupl
#

user node[:wstore][:user] do
    comment "WStore user"
    home node[:wstore][:root_dir]
    system true
    shell "/bin/false"
end

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

python_virtualenv node[:wstore][:virtualenv] do
    action :create
end

include_recipe "mongodb"

mongodb_instance "mongodb" do
  smallfiles   true
end


xvfb_pkgs = value_for_platform_family(
   "debian" => ["xvfb"],
   "rhel" => ["xorg-x11-server-Xvfb"],
   "fedora" => ["xorg-x11-server-Xvfb"],
   "default" => ["xvfb"]
)

# Install Xvfb package
xvfb_pkgs.each do |pkg|
    package pkg do
        action :install
    end
end

# add the EPEL repo
yum_repository 'epel' do
  description 'Extra Packages for Enterprise Linux'
  mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch'
  action :add
end

case node[:platform_family]
when "debian"
  package "wkhtmltopdf" do
    action :install
  end

when "rhel","fedora"

  file_name = ""
  source_file = ""
  if node['kernel']['machine'] == 'x86_64'
    file_name = "/tmp/wkhtmltox-0.12.1_linux-centos6-amd64.rpm"
    source_file = "http://sourceforge.net/projects/wkhtmltopdf/files/archive/0.12.1/wkhtmltox-0.12.1_linux-centos6-amd64.rpm/download"
  else
    file_name = "/tmp/wkhtmltox-0.12.1_linux-centos6-i386.rpm"
    source_file = "http://sourceforge.net/projects/wkhtmltopdf/files/archive/0.12.1/wkhtmltox-0.12.1_linux-centos6-i386.rpm/download"
  end
  
  remote_file file_name do
    source source_file
  end

  rpm_package file_name do
    source file_name
    action :install
  end

else
  Chef::Log.warn("No support for wkhtmltopdf in your system")
end

directory node[:wstore][:ins_dir] do
  owner node[:wstore][:user]
  group node[:wstore][:group]
  action :create
end

# Get WStore package
remote_file "/tmp/APPS-Store-WStore-3.3.1.zip" do
  source "https://forge.fi-ware.org/frs/download.php/1399/APPS-Store-WStore-3.3.1.zip"
end

execute 'wstore unzip' do
  cwd "/tmp"
  command "unzip -o APPS-Store-WStore-3.3.1.zip -d #{node[:wstore][:ins_dir]}"
end

execute 'chown' do
  cwd node[:wstore][:ins_dir]
  command "chown -R #{node[:wstore][:user]}:#{node[:apache][:group]} wstore"
end

libxml_pkg = value_for_platform_family(
   "debian" => ["libxml2-dev", "libxslt1-dev"],
   "rhel" => ["libxml2-devel", "libxslt-devel"],
   "fedora" => ["libxml2-devel", "libxslt-devel"],
   "default" => ["libxml2-dev", "libxslt1-dev"]
)

libxml_pkg.each do |pkg|
  package pkg do
    action :install
  end
end

# Install WStore dependencies

pip_packages_wstore = [
  "rdflib",
  "lxml",
  "https://github.com/django-nonrel/django/archive/nonrel-1.4.zip",
  "https://github.com/django-nonrel/djangotoolbox/archive/toolbox-1.4.zip",
  "https://github.com/django-nonrel/mongodb-engine/archive/mongodb-engine-1.4-beta.zip",
  "https://github.com/RDFLib/rdflib-jsonld/archive/master.zip",
  "https://github.com/conwetlab/paypalpy/archive/master.zip",
  "nose",
  "django-nose",
  "django-social-auth",
  "django-crontab",
  "Whoosh",
  "Stemming"
]

python_pip "pymongo" do
  virtualenv node[:wstore][:virtualenv]
  version "2.8.1"
  action :install
end

pip_packages_wstore.each do |pip_pkg|
  python_pip pip_pkg do
    virtualenv node[:wstore][:virtualenv]
    action :install
  end
end

directory node[:wstore][:root_dir] + 'media' do
  owner node[:wstore][:user]
  group node[:apache][:group]
  mode 00770
  action :create
end

# Configure WStore settings
directory node[:wstore][:root_dir] + 'media/resources' do
  owner node[:wstore][:user]
  group node[:apache][:group]
  mode 00770
  action :create
  #recursive true
end

directory node[:wstore][:root_dir] + 'media/bills' do
  owner node[:wstore][:user]
  group node[:apache][:group]
  mode 00770
  action :create
  #recursive true
end

include_recipe "apache2"
include_recipe "wstore::mod_wsgi"

file "/tmp/site_id" do
  action :delete
end

execute "check site id" do
  cwd node[:wstore][:root_dir]
  command "#{node[:wstore][:virtualenv]}/bin/python manage.py tellsiteid > /tmp/site_id"
  returns [0, 1, -1]
end

ruby_block "Read site_id file" do
  block do
    spl = File.open('/tmp/site_id').read().split("'")[2]
    node.set[:wstore][:site_id] = spl
  end
  action :create
end

execute "create site" do
  cwd node[:wstore][:root_dir]
  command "#{node[:wstore][:virtualenv]}/bin/python manage.py createsite #{node[:wstore][:site_name]} #{node[:wstore][:site_domain]}"
  not_if { node[:wstore][:site_id] != ''}
end

execute "check site id" do
  cwd node[:wstore][:root_dir]
  command "#{node[:wstore][:virtualenv]}/bin/python manage.py tellsiteid > /tmp/site_id"
  returns [0, 1, -1]
end

ruby_block "Read site_id file" do
  block do
    spl = File.open('/tmp/site_id').read().split("'")[2]
    node.set[:wstore][:site_id] = spl
  end
  action :create
end

file node[:wstore][:root_dir] + "settings.py" do
  action :delete
end

template node[:wstore][:root_dir] + "settings.py" do
  source "settings.py.erb"
  owner node[:wstore][:user]
  group node[:wstore][:group]
  mode 0644
end

file node[:wstore][:root_dir] + "wsgi.py" do
  action :delete
end

template node[:wstore][:root_dir] + "wsgi.py" do
  source "wsgi.py.erb"
  owner node[:wstore][:user]
  group node[:wstore][:group]
  mode 0644
end

apache_site "default" do
     enable false
end

web_app "wstore" do
    template "wstore_app.conf.erb"
    docroot "/var/www"
    enable true
    notifies :reload, "service[apache2]", :immediately
end

# Create initial user if needed
if node[:wstore][:auth] == 'False'
  template node[:wstore][:root_dir] + "/wstore/fixtures/initial_user.json" do
    source "initial_user.json.erb"
    owner node[:wstore][:user]
    group node[:wstore][:group]
    mode 0644
  end

  execute "create user" do
    cwd node[:wstore][:root_dir]
    command "#{node[:wstore][:virtualenv]}/bin/python manage.py loaddata initial_user.json"
  end
end

##
#  Start
##

service "mongodb" do
    action :reload
end

execute "syncdb" do
    cwd node[:wstore][:root_dir]
    command "#{node[:wstore][:virtualenv]}/bin/python manage.py syncdb --noinput"
end

execute "static" do
    cwd node[:wstore][:root_dir]
    command "#{node[:wstore][:virtualenv]}/bin/python manage.py collectstatic --noinput"
end
