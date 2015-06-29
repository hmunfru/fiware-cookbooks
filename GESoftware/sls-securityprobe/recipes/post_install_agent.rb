execute "compile-time-apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end.run_action(:run)

package 'snort' do
     action :install
     ignore_failure true
end

package 'rsyslog' do
     action :install
     ignore_failure true
end

package 'nagios3' do
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

directory "#{node[:securityprobe][:home]}/GeoIP-1.4.7" do
  recursive true
  action :delete
end

directory "#{node[:securityprobe][:home]}/GeoIP-Python-1.2.7" do
  recursive true
  action :delete
end

execute "clean-files" do
  cwd "#{node[:securityprobe][:home]}"
  command "rm -f GeoIP-1.4.7.tar.gz GeoIP.dat.gz GeoIP-Python-1.2.7.tar.gz GeoIPv6.dat.gz GeoLiteCity.dat.gz SecurityProbe.tar.gz"
end

