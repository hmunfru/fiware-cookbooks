#
# Cookbook Name:: tomcat
# Recipe:: 5.5_uninstall
#
# Copyright 2011, Telefonica I+D
#
# Author: Jesus M. Movilla
#
# All rights reserved - Do Not Redistribute

tomcat_dir="#{node["tomcat"]["tomcat_home"]}"

include_recipe "tomcat::tomcat_stop"

directory "#{tomcat_dir}" do
  action :delete
  recursive true
end


