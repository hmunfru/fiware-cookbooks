include_recipe "subversion"
include_recipe "apache2"
include_recipe "mysql"
include_recipe "php"
include_recipe "composer"


package "php-pear" do
        action :install
end

package "php-pdo" do
        action :install
end

package "php-xml" do
        action :install
end

package "php-devel" do
        action :install
end

package "php-process" do
        action :install
end

package "php-mbstring" do
        action :install
end

package "httpd-devel" do
        action :install
end

package "pcre-devel" do
        action :install
end

package "gcc" do
        action :install
end

package "make" do
        action :install
end

php_pear "apc" do
        action :install
end

bash "change_lines" do
  code <<-EOH
        echo " " >> /etc/php.ini
        echo "short_open_tag = Off" >> /etc/php.ini
        echo "extension=apc.so" > /etc/php.d/apc.ini

  EOH
end

directory "/home/sfprojects/#{node['symfony']['proyect']}/lib/vendor" do
  owner "root"
  group "root"
  mode 00644
  action :create
  recursive true
end

subversion "symfony" do
        repository "http://svn.symfony-project.com/branches/1.4"
        destination "/home/sfprojects/#{node['symfony']['proyect']}/lib/vendor/symfony"
        action :sync
end

execute "Create project" do
	command "php /home/sfprojects/#{node['symfony']['proyect']}/lib/vendor/symfony/data/bin/symfony generate:project #{node['symfony']['proyect']}"
	action :run
end

