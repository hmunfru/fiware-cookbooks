remote_file "/tmp/GIS_test_asset.zip" do
  source "https://forge.fiware.org/frs/download.php/1654/FIWARE-test_asset_4.3.2.zip"
end

bash "install_and_configure_software" do
        user "root"
        cwd "/tmp"
        code <<-EOT
                unzip GIS_test_asset.zip
                mkdir -p /var/lib/tomcat7/webapps/geoserver/data/FIWARE-Test_Assets
                cp -rf FIWARE-test_asset /var/lib/tomcat7/webapps/geoserver/data/FIWARE-Test_Assets
        EOT
end
