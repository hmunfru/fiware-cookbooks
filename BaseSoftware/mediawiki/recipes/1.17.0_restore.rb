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

#change mediawiki to read only
script "change2readonly" do
  only_if "test -d #{wikidirectory}"
  interpreter "bash"
  user "root"
  code <<-EOF
   cp #{wikidirectory}/LocalSettings.php #{wikidirectory}/.LocalSettings.php
   echo '$wgReadOnly = "site maintenance";' >> #{wikidirectory}/LocalSettings.php
  EOF
end

# restore backup to database

script "restoredatabase" do
  only_if "test -d #{wikidirectory}"
  interpreter "bash"
  user "root"
  code <<-EOF
    mysql -u wikiuser --password='#{node["mediawiki"]["dbpassword"]}' "#{node["mediawiki"]["dbname"]}" < /tmp/mediawiki.sql
EOF
end

# restore mediawiki to read/write
script "change2normal" do
  only_if "test -d #{wikidirectory}"
  interpreter "bash"
  user "root"
  code <<-EOF
   mv #{wikidirectory}/.LocalSettings.php #{wikidirectory}/LocalSettings.php
  EOF
end

