# Cookbook Name:: virtualcharacters
# Recipe:: uninstall

directory "/var/www/html/VirtualCharacters" do
  action :delete
  recursive true
end
