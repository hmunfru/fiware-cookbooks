#
# Cookbook Name:: iotDiscovery
# Recipe:: 4.1.1_install
#
# Copyright 2014, UNIVERSITY OF SURREY
#
# All rights reserved - Do Not Redistribute
#

execute "add-apt-repository ppa:webupd8team/java" do  
	action :run
end

execute "apt-get update" do  
	action :run
end

#include_recipe 'java'
#include_recipe 'tomcat'

bash "install java" do  
  code <<-EOT		
		echo oracle-java8-set-default shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections		
  EOT
end

package "oracle-java8-set-default" do
        action :install
end

package "tomcat7" do
        action :install
end

package "tomcat7-admin" do
        action :install
end

package "mysql-server" do
  action :install
end

package "mysql-client" do
  action :install
end

# mysql_service 'default' do
  # port '3306'
  # version '5.5'
  # initial_root_password 'root'
  # action :create
# end

# mysql_client 'default' do
  # action :create
# end

package "unzip" do
  action :install
end


remote_file "/tmp/IOT-IoTDiscovery-R4_1.zip" do
  source "http://forge.fi-ware.org/frs/download.php/1556/IOT-IoTDiscovery-R4_1.zip"
end

bash "install_WARs and run SQL script" do
  cwd "/tmp"
  code <<-EOT
    mkdir -p iotDiscovery
	unzip IOT-IoTDiscovery-R4_1.zip -d iotDiscovery/
	cd /tmp/iotDiscovery	
    cp -r tomcat/s2w.war /var/lib/tomcat7/webapps
	cp -r tomcat/ngsi9.war /var/lib/tomcat7/webapps
	cp -r tomcat/tomcat-users.xml /var/lib/tomcat7/conf
	mysql < /tmp/iotDiscovery/sql/triples-store.sql
  EOT
end
