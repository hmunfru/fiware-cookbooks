# Cookbook Name:: synchronization
# Recipe:: uninstall

directory "/var/www/html/Synchronization" do
  action :delete
  recursive true
end

bash "uninstall Tundra" do
  user "root"
  code "apt-get -y remove realxtend-tundra"
end
