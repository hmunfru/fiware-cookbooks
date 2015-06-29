execute "apt-get update" do  
	action :run
end

package "unzip" do
  action :install
end

package "tomcat7" do
        action :install
end

remote_file "/tmp/RealVirtualInteraction_Client_Binary-3.3.3.tar.gz" do
  source "https://forge.fi-ware.org/frs/download.php/1284/RealVirtualInteraction_Client_Binary-3.3.3.tar.gz"
end

remote_file "/tmp/realvirtualinteractionbackend.jar" do
  source "https://forge.fi-ware.org/frs/download.php/1282/MIWI-RealVirtualBackend-Release-3.3.3.jar"
end

bash "Setup RvI Server" do
  cwd "/"
  code <<-EOT
    mkdir -p RvI_server
    cp -r /tmp/realvirtualinteractionbackend.jar /RvI_server/realvirtualinteractionbackend.jar
  EOT
end

bash "Setup RvI test client" do
  cwd "/tmp"
  code <<-EOT
    mkdir -p RVI_Client && tar -zxvf RealVirtualInteraction_Client_Binary-3.3.3.tar.gz -C RVI_Client/
    cp -r RVI_Client /var/lib/tomcat7/webapps
  EOT
end

cookbook_file "index.html" do
  path "/var/lib/tomcat7/webapps/RVI_Client/index.html"
  action :create
end

