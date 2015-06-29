#
# Cookbook Name:: mediawiki
# Recipe:: default
#
# Copyright 2011, Telefónica I+D
#
# All rights reserved - Do Not Redistribute
#

mediawikiversion="1.17.0"
mediawikiurl=""
wikidirectory="#{node["mediawiki"]["docroot"]}#{node["mediawiki"]["path"]}"
#ENV["http_proxy"]="http://chefserver.hi.inet:8888/"
if platform?("debian", "ubuntu")
  include_recipe "mysql::server2"
else
  include_recipe "mysql::server"
end
include_recipe "mysql::client"
include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "php"
include_recipe "php::module_mysql"

directory "/etc/mediawiki"
# compare new config with the old config
template "/etc/mediawiki/mediawikiconfig.new" do
  source "mediawiki.erb"
  only_if {File.exists?("/etc/mediawiki/mediawikiconfig")}
end

script "updateconfig" do 
  interpreter "python"
  cwd "/etc/mediawiki"
  only_if {File.exists?("/etc/mediawiki/mediawikiconfig")}
  code <<-EOF
import os
oldvalues={}
newvalues={}
sp="$wgScriptPath"
logo="logogif"
for line in open('/etc/mediawiki/mediawikiconfig'):
    splittedline=line.split('=',1)
    if len(splittedline) !=2 : continue
    oldvalues[splittedline[0].strip()]=splittedline[1].strip()
for line in open('/etc/mediawiki/mediawikiconfig.new'):
    splittedline=line.split('=',1)
    if len(splittedline) !=2 : continue
    newvalues[splittedline[0].strip()]=splittedline[1].strip()
# mv directory if scriptPath changed
if oldvalues[sp] != newvalues[sp] :
   os.rename("#{node["mediawiki"]["docroot"]}"+oldvalues[sp],"#{wikidirectory}")
# remove logo file to fore reload if parameter changed.
if oldvalues.has_key(logo) ^ newvalues.has_key(logo) or  newvalues.has_key(logo) and  newvalues[logo] != oldvalues[logo] :
    os.remove("#{wikidirectory}/skins/common/logo.gif")


EOF
end

file "/etc/mediawiki/mediawikiconfig.new" do
action :delete
end

# save new config
template "/etc/mediawiki/mediawikiconfig" do
  source "mediawiki.erb"
end

# install mediawiki if not already installed

cookbook_file "/tmp/mediawiki-#{mediawikiversion}.tar.gz" do
  not_if "test -d #{wikidirectory}"
  source "mediawiki-#{mediawikiversion}.tar.gz"
  mode "0644"
  action :create_if_missing 
end


script "installmediawiki" do
  not_if "test -d #{wikidirectory}"
  interpreter "bash"
  user "root"
  cwd "#{node["mediawiki"]["docroot"]}"
  code <<-EOF
    tar xzvf /tmp/mediawiki-#{mediawikiversion}.tar.gz
    mv mediawiki-#{mediawikiversion} #{wikidirectory}
    cd #{wikidirectory}
    mysql -u root --password="#{node["mysql"]["server_root_password"]}" <<MYSQLBLOCK
     create database #{node["mediawiki"]["dbname"]};
     grant index, create, select, insert, update, drop, delete, alter, lock tables on #{node["mediawiki"]["dbname"]}.* to 'wikiuser'@'localhost' identified by '#{node["mediawiki"]["dbpassword"]}';
MYSQLBLOCK
    php maintenance/install.php --pass #{node["mediawiki"]["pass"]} --dbname #{node["mediawiki"]["dbname"]} --dbpass #{node["mediawiki"]["dbpassword"]} #{node["mediawiki"]["wikiname"]} #{node["mediawiki"]["admin"]} 
    test $? -eq 0 || rm -rf #{wikidirectory}
    rm -rf config mw-config
    mv LocalSettings.php .LocalSettings.orig.php
  EOF
end

# apply configuration 
script "mergeconfig" do
  interpreter "python"
  cwd "#{wikidirectory}"
  code <<-EOF
import os
values=dict()
newfile=open('LocalSettings.php','w')
for line in open('/etc/mediawiki/mediawikiconfig'):
    if not line.startswith('$') : continue
    splittedline=line.split('=',1)
    if len(splittedline) !=2 : continue
    values[splittedline[0].strip()]=splittedline[1].strip()
for line in open('.LocalSettings.orig.php'):
    if line.startswith('$') | line.startswith('\#$') : 
      splittedline=line.split('=',1)
      if len(splittedline) == 2 and values.has_key(splittedline[0].strip()):
        key=splittedline[0].strip() 
        print >> newfile, key+' = "'+values.pop(key)+'";'
        continue 
    print >> newfile, line,
for key in values:
  print >> newfile, key+' = '+values[key]
EOF
end

# download logo if not exists or copy default logo
#remote_file "#{wikidirectory}/skins/common/logo.gif" do
#  source "#{node["mediawiki"]["logogif"]}"
#  mode "0544"
#  action :create_if_missing
#  ignore_failure true
#end

cookbook_file "#{wikidirectory}/skins/common/logo.gif" do
  source "mediawiki.gif" 
  mode "0544"
  action :create_if_missing 
end

