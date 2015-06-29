execute "compile-time-apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end.run_action(:run)

package 'gcc' do
     action :install
     ignore_failure true
end

package 'zlib1g-dev' do
     action :install
     ignore_failure true
end

package 'make' do
     action :install
     ignore_failure true
end

package 'python-dev' do
     action :install
     ignore_failure true
end

package 'geoip-bin' do
     action :install
     ignore_failure true
end

package 'geoip-database' do
     action :install
     ignore_failure true
end

package 'python-pyinotify' do
     action :install
     ignore_failure true
end

package 'python-setuptools' do
     action :install
     ignore_failure true
end

execute "wget-GeoIP" do
  cwd "#{node["securityprobe"]["home"]}"
  command "wget http://repositories.testbed.fi-ware.org/webdav/sls/GeoIP-1.4.7.tar.gz"
end

execute "untar-GeoIP" do
  cwd "#{node["securityprobe"]["home"]}"
  command "tar -zxvf GeoIP-1.4.7.tar.gz"
end

execute "install-GeoIP" do
  cwd "#{node["securityprobe"]["home"]}/GeoIP-1.4.7"
  command "./configure --prefix=/usr; make; make install"
end

execute "wget-GeoIP-Python" do
  cwd "#{node["securityprobe"]["home"]}"
  command "wget http://repositories.testbed.fi-ware.org/webdav/sls/GeoIP-Python-1.2.7.tar.gz"
end

execute "untar-GeoIP-Python" do
  cwd "#{node["securityprobe"]["home"]}"
  command "tar -zxvf GeoIP-Python-1.2.7.tar.gz"
end

execute "install-GeoIP-Python" do
  cwd "#{node["securityprobe"]["home"]}/GeoIP-Python-1.2.7"
  command "python setup.py build"
  command "python setup.py install"
end

directory "/usr/share/geoip" do
  owner node["securityprobe"]["user"]
  group node["securityprobe"]["group"]
  mode 00755
  action :create
end

cookbook_file "#{node['securityprobe']['home']}/GeoLiteCity.dat.gz" do
   source "GeoLiteCity.dat.gz"
   mode 0755
   owner node["securityprobe"]["user"]
   group node["securityprobe"]["group"]
end

execute "install-GeoDat" do
  cwd "#{node["securityprobe"]["home"]}"
  command "gunzip -c GeoLiteCity.dat.gz > /usr/share/geoip/GeoLiteCity.dat"
end

cookbook_file "#{node['securityprobe']['home']}/GeoIPv6.dat.gz" do
   source "GeoIPv6.dat.gz"
   mode 0755
   owner node["securityprobe"]["user"]
   group node["securityprobe"]["group"]
end

execute "install-GeoIPv6" do
  cwd "#{node["securityprobe"]["home"]}"
  command "gunzip -c GeoIPv6.dat.gz > /usr/share/geoip/GeoIPv6.dat"
end

cookbook_file "#{node['securityprobe']['home']}/GeoIP.dat.gz" do
   source "GeoIP.dat.gz"
   mode 0755
   owner node["securityprobe"]["user"]
   group node["securityprobe"]["group"]
end

execute "install-GeoIPdat" do
  cwd "#{node["securityprobe"]["home"]}"
  command "gunzip -c GeoIP.dat.gz > /usr/share/geoip/GeoIP.dat"
end

execute "install-ptz" do
  cwd "#{node["securityprobe"]["home"]}"
  command "easy_install pytz"
end

package 'python-nmap' do
     action :install
     ignore_failure true
end
 
package 'nmap' do
     action :install
     ignore_failure true
end

package 'python-ldap' do
     action :install
     ignore_failure true
end

package 'python-libpcap' do
     action :install
     ignore_failure true
end

package 'python-adodb' do
     action :install
     ignore_failure true
end

package 'openjdk-6-jdk' do
     action :install
     ignore_failure true
end


