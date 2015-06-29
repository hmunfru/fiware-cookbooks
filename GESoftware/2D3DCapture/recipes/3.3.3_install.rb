execute "apt-get update" do  
	action :run
end

package "unzip" do
  action :install
end

package "tomcat7" do
        action :install
end

package "mysql-server" do
  action :install
end

package "mysql-client" do
  action :install
end

package "python-dev" do
  action :install
end

package "libmysqlclient-dev" do
  action :install
end

package "python-pip" do
  action :install
end

package "libjpeg-dev" do
  action :install
end

package "libfreetype6" do
  action :install
end

package "libfreetype6-dev" do
  action :install
end

package "zlib1g-dev" do
  action :install
end


remote_file "/tmp/TwoDThreeDCapture.war" do
  source "https://github.com/Cyberlightning/Cyber-WeX/raw/master/2D-3D-Capture/TwoDThreeDCapture.war"
end

bash "install_and_configure_2D3D_capture_client" do
        cwd "/tmp"
        code <<-EOT
                mv TwoDThreeDCapture.war /var/lib/tomcat7/webapps
        EOT
end

#copy tomcat configuration file which sets tomcat port to 9090
cookbook_file "server.xml" do
  path "/var/lib/tomcat7/conf/server.xml"
  action :create
end


include_recipe "2D3DCapture::setup_2D3D_mysql_db"

bash "setup_python" do
  code <<-EOH
    sudo pip install -U pip
    sudo pip install Flask
    sudo pip install MySQL-python
    sudo pip install --upgrade distribute   
    sudo service tomcat7 restart
  EOH
end
