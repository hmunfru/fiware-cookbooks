# Cookbook Name:: 3d-map-tiles
# Recipe:: uninstall

directory "/var/webservices/3d-map-tiles" do
  action :delete
  recursive true
end

file "/etc/#{node["apache"]["package_name"]}/conf-enabled/3d-map-tiles.conf" do
  action :delete
end

file "/etc/#{node["apache"]["package_name"]}/conf-available/3d-map-tiles.conf" do
  action :delete
end

#Remove include of conf in CentOS httpd.conf

# Restart apache service
service node["apache"]["package_name"] do
	action [:restart]
end

# let's not remove installed packages git, php and apache because we don't know if something else needs it
