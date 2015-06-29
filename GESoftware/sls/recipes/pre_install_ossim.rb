
execute "compile-time-apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end.run_action(:run)

package 'pkg-config' do
     action :install
     ignore_failure true
end

package 'intltool' do
 action :install
     ignore_failure true
end

package 'autoconf' do
     action :install
     ignore_failure true
end

package 'automake' do
     action :install
     ignore_failure true
end

package 'libtool' do
     action :install
     ignore_failure true
end

package 'e2fsprogs' do
     action :install
     ignore_failure true
end

package 'hdparm' do
     action :install
     ignore_failure true
end

package 'unzip' do
     action :install
     ignore_failure true
end

package 'default-jdk' do
     action :install
     ignore_failure true
end

package 'uuid' do
     action :install
     ignore_failure true
end

package 'uuid-dev' do
     action :install
     ignore_failure true
end

package 'libglib2.0-dev' do
     action :install
     ignore_failure true
end

package 'gnet2.0' do
     action :install
     ignore_failure true
end

package 'libgnet2.0' do
     action :install
     ignore_failure true
end

package 'libgnet-dev' do
     action :install
     ignore_failure true
end

package 'libxml2' do
     action :install
     ignore_failure true
end

package 'libxml2-dev' do
     action :install
     ignore_failure true
end

package 'libssl-dev' do
     action :install
     ignore_failure true
end

package 'libxslt1-dev' do
     action :install
     ignore_failure true
end

package 'libjson-glib-1.0' do
     action :install
     ignore_failure true
end

package 'libjson-glib-dev' do
     action :install
     ignore_failure true
end

package 'php5' do
     action :install
     ignore_failure true
end

package 'libapache2-mod-php5' do
     action :install
     ignore_failure true
end

package 'libphp-adodb' do
     action :install
     ignore_failure true
end

package 'php5-common' do
     action :install
     ignore_failure true
end

package 'php5-json' do
     action :install
     ignore_failure true
end

package 'php5-geoip' do
     action :install
     ignore_failure true
end

package 'libgeoip1' do
     action :install
     ignore_failure true
end

package 'libgeoip-dev' do
     action :install
     ignore_failure true
end

package 'python-geoip' do
     action :install
     ignore_failure true
end

package 'geoclue' do
     action :install
     ignore_failure true
end

package 'geoclue-hostip' do
     action :install
     ignore_failure true
end

package 'geoclue-localnet' do
     action :install
     ignore_failure true
end

package 'geoclue-manual' do
     action :install
     ignore_failure true
end

package 'geoclue-yahoo' do
     action :install
     ignore_failure true
end

package 'libgeoclue0' do
     action :install
     ignore_failure true
end

package 'fprobe' do
     action :install
     ignore_failure true
end

package 'fprobe-ng' do
     action :install
     ignore_failure true
end

package 'libmysqlclient18' do
     action :install
     ignore_failure true
end

package 'php5-mysql' do
     action :install
     ignore_failure true
end

package 'php5-dev' do
     action :install
     ignore_failure true
end

package 'python-mysqldb' do
     action :install
     ignore_failure true
end

package 'libxml-simple-perl' do
     action :install
     ignore_failure true
end

package 'libdbi-perl' do
     action :install
     ignore_failure true
end

package 'libdbd-mysql-perl' do
     action :install
     ignore_failure true
end

package 'libapache-dbi-perl' do
     action :install
     ignore_failure true
end

package 'libnet-ip-perl' do
     action :install
     ignore_failure true
end

package 'libsoap-lite-perl' do
     action :install
     ignore_failure true
end

package 'libc6-dev' do
     action :install
     ignore_failure true
end

package 'libmysqlclient-dev' do
     action :install
     ignore_failure true
end

package 'libidn11-dev' do
     action :install
     ignore_failure true
end

package 'socat' do
   action :install
     ignore_failure true
end

cookbook_file "/etc/init.d/ossim-socat" do
   source "ossim-socat"
   mode 0755
   owner "root" 
   group "root" 
end

execute "wget-mysql-udf-ipv6" do
  cwd "#{node['sls']['install_dir']}"
  command "wget http://repositories.testbed.fi-ware.org/webdav/sls/mysql-udf-ipv6.tar.gz"
end

execute "untar-mysql-udf-ipv6" do
  cwd "#{node['sls']['install_dir']}"
  command "tar -zxvf mysql-udf-ipv6.tar.gz"
end

execute "install-mysql-udf-ipv6" do
  cwd "#{node['sls']['install_dir']}/watchmouse-mysql-udf-ipv6-c733da2d2703"
  command "make; make install"
end

service "mysql" do
  action :restart
end

cookbook_file "#{node['sls']['install_dir']}/mysql_udf_functions.sql" do
   source "mysql_udf_functions.sql"
   mode 0755
   owner node["sls"]["user"]
   group node["sls"]["group"]
end

execute "create-SLS-db-tables" do
 command "mysql -uroot --password='#{node['ossim']['server']['db_pass']}'  < #{node['sls']['install_dir']}/mysql_udf_functions.sql"
end

cookbook_file "#{node['sls']['install_dir']}/sql_PCI.sql" do
   source "sql_PCI.sql"
   mode 0755
   owner node["sls"]["user"]
   group node["sls"]["group"]
end

execute "create-PCI-db-tables" do
 command "mysql -uroot --password='#{node['ossim']['server']['db_pass']}'  < #{node['sls']['install_dir']}/sql_PCI.sql"
end

execute "wget-libgda" do
   cwd "#{node['sls']['install_dir']}"
   command "wget http://repositories.testbed.fi-ware.org/webdav/sls/libgda-4.2.13_OSSIM.tar.gz"
end

execute "untar-libgda" do
  cwd "#{node['sls']['install_dir']}"
  command "tar -zxvf libgda-4.2.13_OSSIM.tar.gz"
end

execute "compile-libgda" do
  cwd "#{node['sls']['install_dir']}/libgda-4.2.13"
  command "./configure --enable-mysql=yes --with-mysql=yes --prefix=/usr; make; make install"
end

directory "/etc/libgda-4.0" do
  owner node["sls"]["user"]
  group node["sls"]["group"]
  mode 00755
  action :create
end

template "/etc/libgda-4.0/config" do
    source "config_libgda4.0.erb"
    mode 0644
    owner "root"
    group "root"
end

execute "wget-var_www_ossim" do
  cwd "#{node['sls']['install_dir']}"
  command "wget http://repositories.testbed.fi-ware.org/webdav/sls/var_www_ossim.tar.gz"
end

execute "untar-var-www-ossim" do
  cwd "#{node['sls']['install_dir']}"
  command "tar -zxvf var_www_ossim.tar.gz -C /var/www"
end


