package "tomcat7" do
  action :remove
end

package "mysql-server" do
  action :remove
end

package "mysql-client" do
  action :remove
end

package "python-dev" do
  action :remove
end

package "libmysqlclient-dev" do
  action :remove
end

package "python-pip" do
  action :remove
end

package "libjpeg-dev" do
  action :remove
end

package "libfreetype6" do
  action :remove
end

package "libfreetype6-dev" do
  action :remove
end

package "zlib1g-dev" do
  action :remove
end

include_recipe "2D3DCapture::remove_2D3D_mysql_db"

