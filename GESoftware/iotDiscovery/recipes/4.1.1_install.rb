#
# Cookbook Name:: iotDiscovery
# Recipe:: 4.1.1_install
#
# Copyright 2014, UNIVERSITY OF SURREY
#
# All rights reserved - Do Not Redistribute
#

#stop Apache http server if running
service "apache2" do
        action :stop
end

#add install repository to apt
execute "add-apt-repository ppa:webupd8team/java" do  
	action :run
end

#update apt repository
execute "apt-get update" do  
	action :run
end

package "debconf" do
        action :install
		options "--yes"
end

bash "install java" do  
  code <<-EOT		
		echo oracle-java8-set-default shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections		
  EOT
end

package "oracle-java8-set-default" do
	action :install
	options "--yes"
end

package "tomcat7" do
	action :install
	options "--yes"
end

package "tomcat7-admin" do
	action :install
	options "--yes"
end

package "mysql-server" do
	action :install
	options "--yes"
end

package "mysql-client" do
	action :install
	options "--yes"
end

package "unzip" do
	action :install
	options "--yes"
end

directory "/tmp/*" do
	recursive true
	action :delete
end

remote_file "/tmp/IOT-IoTDiscovery-latest.zip" do
#	source "http://forge.fi-ware.org/frs/download.php/1574/IOT-IoTDiscovery-latest.zip"
	source "http://iot.ee.surrey.ac.uk/fiware/releases/IOT-IoTDiscovery-latest.zip"
end

bash "install_WARs and run SQL script" do
	cwd "/tmp"
	code <<-EOT
		mkdir -p iotDiscovery
		unzip IOT-IoTDiscovery-latest.zip -d iotDiscovery/
		cd /tmp/iotDiscovery	
		cp -r tomcat/s2w.war /var/lib/tomcat7/webapps
		cp -r tomcat/ngsi9.war /var/lib/tomcat7/webapps
		cp -r tomcat/tomcat-users.xml /var/lib/tomcat7/conf
		mysql < /tmp/iotDiscovery/sql/triple-store.sql
		echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/default/tomcat7
	EOT
end

service "tomcat7" do
	action :start
end

service "mysql" do
	action :start
end
