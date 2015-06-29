bash "uninstall_gis_test_client" do
	user "root"
	code <<-EOT
		rm -rf /var/lib/tomcat7/webapps/gis_test_client
	EOT
end
