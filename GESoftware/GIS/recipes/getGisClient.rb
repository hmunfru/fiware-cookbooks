remote_file "/tmp/GIS_test_client.zip" do
  source "https://forge.fiware.org/frs/download.php/1655/GISDataProvider-test_client_4.3.2.zip"
end

bash "install_and_configure_software" do
        user "root"
	cwd "/tmp"
	code <<-EOT
		unzip GIS_test_client.zip
		mv GIS gis_test_client
		cp -rf gis_test_client /var/lib/tomcat7/webapps
	EOT
end
