if platform?("ubuntu") 
	log "Ubuntu detected, installing GIS data provider..."

execute "apt-get update" do  
	action :run
end

package "tomcat7" do
        action :install
end

package "unzip" do
  action :install
end

remote_file "/tmp/geoserver.war" do
  source "https://forge.fiware.org/frs/download.php/1643/geoserver.war"
end

include_recipe "GIS::getGisClient"

bash "install_and_configure_software" do
        #user "root"
        cwd "/tmp"
        code <<-EOT
                mv geoserver.war /var/lib/tomcat7/webapps
		service tomcat7 restart
        EOT
end

include_recipe "GIS::getGisTestAssets"

else 
	Chef::Application.fatal!("This chef recipe for installing the GIS data provider supports only Ubuntu")
end
