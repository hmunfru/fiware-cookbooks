bash "uninstall_and_configure_software" do
    user "root"
    cwd "/tmp"
    code <<-EOT
        rm -r /var/lib/tomcat7/webapps/geoserver.war
	rm -rf /var/lib/tomcat7/webapps/geoserver
    EOT
end

include_recipe "GIS::removeGisClient"

include_recipe "GIS::removeGisTestAssets"


package "tomcat7" do
	action :remove
end

package "unzip" do
  action :remove
end

execute "apt-get autoremove -y" do  
    action :run
end
