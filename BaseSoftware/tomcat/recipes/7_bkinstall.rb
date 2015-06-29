#
# Cookbook Name:: tomcat
# Recipe:: 7_install
#
# Copyright 2011, Telefonica I+D
#
# Author: Jesus M. Movilla
#
# All rights reserved - Do Not Redistribute

tomcat_dir="#{node["tomcat"]["tomcat_home"]}"
tomcat_tar="http://root:temporal@130.206.80.112/webdav/product/tomcat/7/tomcat7-bin.tar"
remote_file "/tmp/tomcat.tar" do
  source "#{tomcat_tar}"
  not_if "test -d #{tomcat_dir}"
end

script "install" do
  not_if "test -d #{tomcat_dir}"
  interpreter "bash"
  user "root"
  cwd "/opt"
  code <<-EOH
  cd $(dirname #{tomcat_dir})
  rm -rf /tmp/apache-tomcat-7.*
  tar xvf /tmp/tomcat.tar
  mv apache-tomcat-7.* #{tomcat_dir}
  EOH
end

file "/tmp/tomcat.tar" do
  action :delete
end

include_recipe "tomcat::tomcat_start"


