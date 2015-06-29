bash "uninstall_and_configure_software" do
    user "root"
    cwd "/tmp"
    code <<-EOT
	rm -rf /var/lib/tomcat7/webapps/RVI_Client
	rm -rf /RvI_server
    EOT
end

package "unzip" do
  action :remove
end

package "tomcat7" do
  action :remove
end


