bash "uninstall_gis_test_client" do
	user "root"
	code <<-EOT
		rm -rf /var/lib/tomcat7/webapps/geoserver/data/FIWARE-Test_Assets
	EOT
end
