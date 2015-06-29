# Cookbook Name:: cloud-rendering
# Recipe:: uninstall

directory "/usr/local/src/cloud-rendering" do
  action :delete
  recursive true
end

file "/etc/init.d/cloud-rendering-service.sh" do
	action :delete
end
