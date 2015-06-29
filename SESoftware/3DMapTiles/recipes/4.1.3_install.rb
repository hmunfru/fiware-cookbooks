# Cookbook Name:: 3d-map-tiles
# Recipe:: install


if node["platform_family"] == "rhel"
	print "You are trying to run this recipe on a CentOS system. Currently, installing 3D-Map-Tiles via recipe is only supported for Ubuntu14.04."
end

return if node["platform_family"] == "rhel"

# Install git to checkout 3d map tiles SE repo
package "git" do
	action :install
end

# Install apache service. Package name depends on OS: apache2 for Ubuntu, http for CentOS.
# Name is resolved in the attributes/default.rb script
package node["apache"]["package_name"] do
  action :install
end

# Install php5 which is needed for 3D map-tiles
package node["php"]["package_name"] do
	action :install
end

#package "libapache2-mod-php5" do
#	action :install
#	ignore_failure true
#end

# Create directory which should contain webservices on the server
directory "/var/webservices/" do
	action :create
	ignore_failure true
end

# Create directory to which 3d map tiles SE should be checked out
directory "/var/webservices/3d-map-tiles/" do
	action :create
	ignore_failure true
end

# Checkout stable branch of Map Tiles SE from Github
git "/var/webservices/3d-map-tiles/" do
  repository "https://github.com/stlemme/3d-map-tiles.git"
  reference "stable"
  action :sync
  ignore_failure true
end 

# copy sample config file to be used as initial config file
bash "rename config" do
  code "cp /var/webservices/3d-map-tiles/config.json.sample /var/webservices/3d-map-tiles/config.json"
end

# For CentOS, we need to create the sites-enabled and sites-availabe folders and have to include the
# sites-enabled folder to the server config
#if node["platform_family"] == "rhel"
#   
#	file = Chef::Util::FileEdit.new("/etc/httpd/conf/httpd.conf")
#	file.insert_line_if_no_match("Include /etc/httpd/conf-enabled/3d-map-tiles.conf", "Include /etc/httpd/conf-enabled/3d-map-tiles.conf")
#	file.search_file_replace_line(regex, newline)
#	file.write_file
#	
#	directory "/etc/httpd/conf-enabled/" do
#		action :create
#	end
#	
#	directory "/etc/httpd/conf-available/" do
#		action :create
#	end
#else
	# delete / modify / ../ default sites-enabled in Ubuntu
#end

# Copy Alias-Config to available sites
cookbook_file "/etc/#{node["apache"]["package_name"]}/conf-available/3d-map-tiles.conf" do
	source "3d-map-tiles.conf"	
end

# Enable 3D-Map-Tiles alias on server
bash "set conf-enabled" do
	code "ln -s /etc/#{node["apache"]["package_name"]}/conf-available/3d-map-tiles.conf /etc/#{node["apache"]["package_name"]}/conf-enabled/3d-map-tiles.conf"
	ignore_failure true
end

# The following commands enable packages needed in apache for Ubuntu.
# These steps are not yet supported on CentOS Platforms!

execute "a2enmod-rewrite" do
	command "/usr/sbin/a2enmod rewrite"
	action :run
	only_if {node['platform_family'] == "debian"}
	creates "/etc/apache2/mods-enabled rewrite.load"
end

execute "a2enmod-headers" do
	command "/usr/sbin/a2enmod headers"
	action :run
	only_if {node['platform_family'] == "debian"}
	creates "/etc/apache2/mods-enabled headers.load"
end

execute "a2enmod-php5" do
	command "/usr/sbin/a2enmod php5"
	action :run
	only_if {node['platform_family'] == "debian"}
	creates "/etc/apache2/mods-enabled php5.load"
end

# Set access rights for tmp folder so it can be written by 3d-map-tiles cache
directory "/tmp/" do
	mode "1777"
end

# Make sure apache is running after installation
service node["apache"]["package_name"] do
	action [:start, :enable]
end

# Restart apache service
service node["apache"]["package_name"] do
	action [:restart]
end

