execute "wget-os-sim" do
  cwd "#{node['sls']['install_dir']}"
  command "wget http://repositories.testbed.fi-ware.org/webdav/sls/os-sim-4.1.0-src.tar.gz"
end

execute "untar-ossim" do
  cwd "#{node['sls']['install_dir']}"
  command "tar -zxvf os-sim-4.1.0-src.tar.gz"
end

bash "compile-ossim" do
  user node["sls"]["user"]
  group node["sls"]["group"]
  cwd "#{node[:sls][:install_dir]}/os-sim"
    code <<-EOH
set -x
cp src/ossim-server /usr/bin
set +x
EOH
end

link "/usr/etc/ossim" do
   to "/etc/ossim"
end

link "/usr/var" do
   to "/var"
end

bash "install-framework" do
  user node["sls"]["user"] 
  group node["sls"]["group"] 
    cwd "#{node[:sls][:install_dir]}/os-sim/frameworkd"
    code <<-EOH
set -x
python setup.py install --prefix=/usr
set +x
EOH
end

bash "install-Flask-SQLAlchemy" do
  user node["sls"]["user"] 
  group node["sls"]["group"] 
    cwd "#{node[:sls][:install_dir]}"
    code <<-EOH
set -x
easy_install Flask-SQLAlchemy
set +x
EOH
end

bash "install-scripts" do
  user node["sls"]["user"]
  group node["sls"]["group"]
    cwd "#{node[:sls][:install_dir]}/os-sim/scripts"
    code <<-EOH
set -x
make; make install
set +x
EOH
end

bash "install-locale" do
  user node["sls"]["user"]
  group node["sls"]["group"]
    cwd "#{node[:sls][:install_dir]}/os-sim/locale"
    code <<-EOH
set -x
make; make install
set +x
EOH
end

bash "install-alienvault" do
  user node["sls"]["user"]
  group node["sls"]["group"]
    cwd "#{node[:sls][:install_dir]}/os-sim/alienvault-idm"
    code <<-EOH
set -x
cp alienvault-idm /usr/bin
set +x
EOH
end

execute "wget-ossim_utils_scripts" do
  cwd "#{node['sls']['install_dir']}"
  command "wget http://repositories.testbed.fi-ware.org/webdav/sls/ossim_utils_scripts.tar.gz"
end

execute "untar-ossim_utils_scripts" do
  cwd "#{node['sls']['install_dir']}"
  command "tar -zxvf ossim_utils_scripts.tar.gz -C /usr/bin"
end

execute "wget-ossim_etc" do
  cwd "#{node['sls']['install_dir']}"
  command "wget http://repositories.testbed.fi-ware.org/webdav/sls/ossim_etc.tar.gz"
end

execute "backup-php5-conf" do
  cwd "#{node['sls']['install_dir']}"
  command "mv /etc/php5 /etc/php5.backup"
  not_if "test -d /etc/php5.backup"
end

execute "backup-php5" do
  cwd "#{node['sls']['install_dir']}"
  command "rm -rf /etc/php5"
  only_if "test -d /etc/php5.backup"
end

execute "untar-ossim_etc" do
  cwd "#{node['sls']['install_dir']}"
  command "tar -zxvf ossim_etc.tar.gz -C /etc"
end

directory "#{node['ossim']['log']['path']}" do
  owner node["sls"]["user"]
  group node["sls"]["group"]
  mode 00755
  action :create
end

directory "#{node['ossim']['log']['path']}/idm" do
  owner node["sls"]["user"]
  group node["sls"]["group"]
  mode 00755
  action :create
end

directory "/var/lib" do
  owner node["sls"]["user"]
  group node["sls"]["group"]
  mode 00755
  action :create
end

directory "/var/lib/ossim" do
  owner node["sls"]["user"]
  group node["sls"]["group"]
  mode 00755
  action :create
end

directory "/var/lib/ossim/backup" do
  owner node["sls"]["user"]
  group node["sls"]["group"]
  mode 00755
  action :create
end

directory "/var/lib/ossim/rrd" do
  owner node["sls"]["user"]
  group node["sls"]["group"]
  mode 00755
  action :create
end

