execute "compile-time-apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end.run_action(:run)

package 'apache2' do
     action :install
     ignore_failure true
end

package 'apache2-doc' do
 action :install
     ignore_failure true
end

package 'libapache2-mod-proxy-html' do
     action :install
     ignore_failure true
end

package 'libapache2-mod-authnz-external' do
     action :install
     ignore_failure true
end

package 'libapache2-mod-dnssd' do 
     action :install
     ignore_failure true
end

package 'libapache2-mod-perl2' do
     action :install
     ignore_failure true
end

package 'tcptrack' do
     action :install
     ignore_failure true
end

package 'ntop' do
     action :install
     ignore_failure true
end

package 'pads' do
     action :install
     ignore_failure true
end

package 'arpwatch' do
     action :install
     ignore_failure true
end

package 'p0f' do
     action :install
     ignore_failure true
end

package 'rrdtool' do
     action :install
     ignore_failure true
end

package 'librrd-dev' do
     action :install
     ignore_failure true
end

package 'librrds-perl' do
     action :install
     ignore_failure true
end

package 'python-rrdtool' do
     action :install
     ignore_failure true
end

package 'librrds-perl' do
     action :install
     ignore_failure true
end

package 'librrdp-perl' do
     action :install
     ignore_failure true
end

package 'mrtg' do
     action :install
     ignore_failure true
end

package 'nfdump' do
     action :install
     ignore_failure true
end

package 'tcpdump' do
     action :install
     ignore_failure true
end

package 'traceroute' do
     action :install
     ignore_failure true
end

package 'tcpreplay' do
     action :install
     ignore_failure true
end

package 'php-xajax' do
     action :install
     ignore_failure true
end

package 'php-fpdf' do
     action :install
     ignore_failure true
end

package 'libphp-jpgraph' do
     action :install
     ignore_failure true
end

package 'php-db' do
     action :install
     ignore_failure true
end

package 'php-http-request' do
     action :install
     ignore_failure true
end

package 'php-net-socket' do
     action :install
     ignore_failure true
end

package 'php-net-url' do
     action :install
     ignore_failure true
end

package 'php-soap' do
     action :install
     ignore_failure true
end

package 'php-xml-parser' do
     action :install
     ignore_failure true
end

package 'php-xml-rss' do
     action :install
     ignore_failure true
end

package 'php5-memcache' do
     action :install
     ignore_failure true
end

package 'ocsinventory-agent' do
     action :install
     ignore_failure true
end

package 'ocsinventory-server' do
     action :install
     ignore_failure true
end

package 'libmcrypt4' do
     action :install
     ignore_failure true
end

package 'php5-mcrypt' do
     action :install
     ignore_failure true
end

execute "wget-ossim_etc" do
  cwd "#{node['sls']['install_dir']}"
  command "wget http://repositories.testbed.fi-ware.org/webdav/sls/ossim_etc.tar.gz"
end

execute "untar-ossim_etc" do
  cwd "#{node['sls']['install_dir']}"
  command "tar -zxvf ossim_etc.tar.gz -C /etc"
end

execute "sysctl-ossim" do
  cwd "#{node['sls']['install_dir']}"
  command "sysctl -p /etc/sysctl.d/ossim.conf"
end

template "/etc/apache2/sites-available/default-ssl.ossim.conf" do
    source "default-ssl.ossim.conf.erb"
    mode 0644
    owner "root"
    group "root"
end

execute "copy-default-ossim-ssl" do
   cwd "#{node['sls']['install_dir']}"
   command "cp /etc/apache2/sites-available/default-ssl.ossim.conf /etc/apache2/sites-enabled/default-ssl.conf"
end

execute "enable-apache2-mods" do
  cwd "#{node['sls']['install_dir']}"
  command "a2enmod alias authn_file authnz_external authz_groupfile auth_basic authz_host authz_user cgi deflate dir env headers mime negotiation perl proxy reqtimeout rewrite setenvif ssl status"
end


execute "copy-ossim-perl5" do
  cwd "#{node['sls']['install_dir']}"
  command "cp /usr/share/ossim/include/ossim_conf.pm /usr/lib/perl5"
  only_if "test -d /usr/share/ossim/include"  
end

template "/usr/share/ocsinventory-reports/dbconfig.inc.php" do
    source "dbconfig.inc.php.erb"
    mode 0644
    owner "root"
    group "root"
end

execute "wget-rrdtool" do
   cwd "#{node['sls']['install_dir']}"
   command "wget http://repositories.testbed.fi-ware.org/webdav/sls/rrdtool-1.4.7.tar.gz"
end

execute "untar-rrdtool" do
  cwd "#{node['sls']['install_dir']}"
  command "tar -zxvf rrdtool-1.4.7.tar.gz"
end

bash "install-rrdtool" do
  user "root"
  group "root"
  cwd "#{node['sls']['install_dir']}/rrdtool-1.4.7"
    code <<-EOH
set -x
./configure; make; make install
set +x
EOH
end

#bash "install-Mail-perl-module" do
#  user "root"
#  group "root"
#  cwd "#{node['sls']['install_dir']}"
#    code <<-EOH
#set -x
#perl -MCPAN -e 'install Mail::Header'
#set +x
#EOH
#end

execute "wget-nfsen" do
   cwd "#{node['sls']['install_dir']}"
   command "wget http://repositories.testbed.fi-ware.org/webdav/sls/nfsen-1.3.6.tar.gz"
end

execute "untar-nfsen" do
  cwd "#{node['sls']['install_dir']}"
  command "tar -zxvf nfsen-1.3.6.tar.gz"
end

bash "install-nfsen" do
  user "root"
  group "root"
  cwd "#{node['sls']['install_dir']}/nfsen-1.3.6"
    code <<-EOH
set -x
./install.pl etc/nfsen.conf
set +x
EOH
end

cookbook_file "/etc/init.d/nfsen" do
   source "nfsen"
   mode 0755
   owner "root" 
   group "root" 
end

service "nfsen" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start]
end

execute "updaterc-nfsen" do
  cwd node[:sls][:install_dir]
  command "update-rc.d nfsen start 20 3 4 5 ."
end

