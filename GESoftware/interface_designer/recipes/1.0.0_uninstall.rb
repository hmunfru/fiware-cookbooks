# Cookbook Name:: interface-designer
# Recipe:: uninstall

directory "/var/www/html/interface-designer" do
    action :delete
    recursive true
end

# let's not remove apache because we don't know if something else needs it