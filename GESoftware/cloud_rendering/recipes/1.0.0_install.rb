# Cookbook Name:: cloud-rendering
# Recipe:: install

package "unzip" do
    action :install
end

package "nodejs" do
    action :install
end

package "nodejs-legacy" do
    action :install
end

package "npm" do
    action :install
end

bash "initialize" do
    cwd "/usr/local/src"
    user "root"
    code <<-EOH
        rm -r -f cloud-rendering
        mkdir cloud-rendering
        npm install -g grunt-cli
    EOH
end

cookbook_file "/etc/init.d/cloud-rendering-service.sh" do
  source "cloud-rendering-service.sh"
  mode 0755
  owner "root"
  group "root"
end

remote_file "/usr/local/src/cloud-rendering/MIWI-CloudRendering_Service.zip" do
    source "https://forge.fi-ware.org/frs/download.php/1166/MIWI-CloudRendering_Service.zip"
    mode 00644
end

bash "installing service" do
    cwd "/usr/local/src/cloud-rendering"
    user "root"
    code <<-EOH
        unzip MIWI-CloudRendering_Service.zip
        rm MIWI-CloudRendering_Service.zip
        mv fiware-cloudrendering-service-3.3.3 service
        cd service
        mv webservice/views/servicereceiver.jqtpl webservice/views/serviceReceiver.jqtpl
        mv webservice/views/servicesender.jqtpl webservice/views/serviceSender.jqtpl
        npm install grunt-cli
        npm install
        cd jsapps
        npm install
        cd ../signalingserver
        npm install
        cd ../webservice
        npm install
        cd ..
        grunt build
    EOH
end
