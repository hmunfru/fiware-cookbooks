# Cookbook Name:: 2d-ui
# Recipe:: uninstall

directory "/var/www/html/2d-ui-input-api" do
    action :delete
    recursive true
end

directory "/var/www/html/2d-ui-web-component" do
    action :delete
    recursive true
end

# let's not remove apache because we don't know if something else needs it