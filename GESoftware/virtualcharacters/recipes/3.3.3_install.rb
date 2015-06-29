# Cookbook name:: virtualcharacters
# Recipe:: install

package "unzip" do
  action :install
end

package "apache2" do
  action :install
end

remote_file "/var/tmp/VirtualCharacters.zip" do
  source "https://forge.fi-ware.org/frs/download.php/1151/MIWI-VirtualCharacters-3.3.3.zip"
  mode 00644
  owner "www-data"
end

bash "unpack VirtualCharacters" do
  code "mkdir /var/www/html/VirtualCharacters"
  code "unzip -o -d /var/www/html/VirtualCharacters /var/tmp/VirtualCharacters.zip"
end

