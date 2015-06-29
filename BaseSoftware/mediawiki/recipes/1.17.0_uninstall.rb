#
# Cookbook Name:: mediawiki
# Recipe:: default
#
# Copyright 2011, Telefónica I+D
#
# All rights reserved - Do Not Redistribute
#

mediawikiversion="1.17.0"
wikidirectory="#{node["mediawiki"]["docroot"]}#{node["mediawiki"]["path"]}"

directory "/etc/mediawiki" do
 action :delete
 recursive true
end

include_recipe "mysql::server"


# delete database and wiki user

script "dropdatabase" do
only_if "test -d #{wikidirectory}"
interpreter "bash"
user "root"
code <<-EOF
    mysql -f -u root --password='#{node["mysql"]["server_root_password"]}' <<MYSQLBLOCK
    drop database if exists #{node["mediawiki"]["dbname"]};
    drop user wikiuser@localhost;
MYSQLBLOCK
  EOF
end

directory "#{wikidirectory}" do
action :delete
recursive true
end


