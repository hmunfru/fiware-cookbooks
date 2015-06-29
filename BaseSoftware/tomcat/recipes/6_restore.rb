#
# Cookbook Name:: tomcat
# Recipe:: 6_restore
#
# Copyright 2011, Telefonica I+D
#
# Author: Jesus M. Movilla
#
# All rights reserved - Do Not Redistribute

include_recipe "tomcat::tomcat_stop"

script "restore_tomcat" do
  interpreter "bash"
  user "root"
  cwd "#{node[:tomcat][:tomcat_home]"
  code <<-EOH
  sleep 10
  cp /tmp/postgresql* #{node[:tomcat][:tomcat_home]/lib/
  tar xvf /tmp/conf.tar conf/
  sleep 10
  EOH
end

include_recipe "tomcat::tomcat_start"
