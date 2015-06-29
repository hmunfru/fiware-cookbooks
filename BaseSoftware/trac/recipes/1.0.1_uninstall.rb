
#stop apache service
service "apache2" do
  action :stop
end

#stop trac service
service "trac" do
  action :stop
end

#remove
package 'trac' do
  action :remove
end

apache_site 'trac.conf' do
  enable false
end



