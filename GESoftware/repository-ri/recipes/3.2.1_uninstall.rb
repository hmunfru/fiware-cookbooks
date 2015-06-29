#
# Cookbook Name:: repository-ri
# Recipe:: 3.2.1_uninstall

# Remove repository package

directory node[:tomcat][:webapp_dir] + "/FiwareRepository" do
    recursive true
    action :delete
end
