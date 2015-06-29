# Cookbook name:: synchronization
# Recipe:: install

package "unzip" do
  action :install
end

package "apache2" do
  action :install
end

package "xvfb" do
  action :install
end

remote_file "/var/tmp/SynchronizationClient.zip" do
  source "https://forge.fi-ware.org/frs/download.php/1139/MIWI-Synchronization-Client-WebTundra-3.3.3.zip"
  mode 00644
  owner "www-data"
end

bash "unpack SynchronizationClient" do
  code "mkdir /var/www/html/Synchronization"
  code "unzip -o -d /var/www/html/Synchronization /var/tmp/SynchronizationClient.zip"
end

remote_file "/var/tmp/SynchronizationServer.deb" do
  source "https://forge.fi-ware.org/frs/download.php/1511/MIWI-Synchronization-Server-2.5.3RC-ubuntu-14.04-amd64.deb"
  mode 00644
  owner "root"
end

bash "install SynchronizationServer" do
  user "root"
  code "dpkg --force-all -i /var/tmp/SynchronizationServer.deb"
end

bash "install SynchronizationServer deps" do
  user "root"
  code "apt-get -y -f install"
end

# This reinstall step is necessary because on some servers libcg dependency cannot be satisfied
# leading to the deps step above actually removing realxtend-tundra. Now we force a reinstall
bash "reinstall SynchronizationServer" do
  user "root"
  code "dpkg --force-all -i /var/tmp/SynchronizationServer.deb"
  ignore_failure true
end
