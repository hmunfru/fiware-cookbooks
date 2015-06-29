# Cookbook Name:: interface-designer
# Recipe:: install

package "unzip" do
    action :install
end

package "apache2" do
    action :install
end

remote_file "/var/tmp/MIWI-interface-designer-3.3.3-with-example.zip" do
    source "https://forge.fi-ware.org/frs/download.php/1263/MIWI-interface-designer-3.3.3-with-example.zip"
    mode 00644
    owner "www-data"
end


bash "Unarchive Interface Designer" do
    code <<-EOH
        unzip -d /var/www/html /var/tmp/MIWI-interface-designer-3.3.3-with-example.zip
        rm -f /var/tmp/MIWI-interface-designer-3.3.3-with-example.zip
        mv /var/www/html/fiware-interface-designer-3.3.3 /var/www/html/interface-designer
    EOH
end