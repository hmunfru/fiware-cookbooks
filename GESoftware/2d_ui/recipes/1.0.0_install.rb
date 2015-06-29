# Cookbook Name:: 2d-ui
# Recipe:: install

package "unzip" do
    action :install
end

package "apache2" do
    action :install
end

remote_file "/var/tmp/MIWI-2D-UI_InputAPI_3.3.3.zip" do
    source "https://forge.fi-ware.org/frs/download.php/1126/MIWI-2D-UI_InputAPI_3.3.3.zip"
    mode 00644
    owner "www-data"
end

remote_file "/var/tmp/MIWI-2D-UI_WebComponent.zip" do
    source "https://forge.fi-ware.org/frs/download.php/926/MIWI-2D-UI_WebComponent.zip"
    mode 00644
    owner "www-data"
end

bash "Unarchive InputAPI" do
    code <<-EOH
        unzip -d /var/www/html /var/tmp/MIWI-2D-UI_InputAPI_3.3.3.zip
        rm -f /var/tmp/MIWI-2D-UI_InputAPI_3.3.3.zip
        mv /var/www/html/fi-ware-2D-UI-master /var/www/html/2d-ui-input-api
    EOH
end

bash "Unarchive WebComponent" do
    code <<-EOH
        unzip -d /var/www/html/2d-ui-web-component /var/tmp/MIWI-2D-UI_WebComponent.zip
        rm -f /var/tmp/MIWI-2D-UI_WebComponent.zip
    EOH
end