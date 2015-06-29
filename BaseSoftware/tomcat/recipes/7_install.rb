#
# Cookbook Name:: tomcat
# Recipe:: 7_install
#
# Copyright 2011, Telefonica I+D
#
# Author: Jesus M. Movilla
#
# All rights reserved - Do Not Redistribute

tomcat_dir=node["tomcat"]["tomcat_home"]
tomcat_tar="http://repositories.testbed.fi-ware.eu/repo/files/apache-tomcat-7.0.61.tar.gz"

java=`which java`

group "tomcat" do
  action :create
end


user "tomcat" do
  gid "tomcat"
  shell "/bin/bash"
  home "/bin/bash"
  system true
  action :create
end


if  node["tomcat"] != nil

  if node["tomcat"]["id_web_server"] !=  nil
    node.default['tomcat']['id_web_server'] = node["tomcat"]["id_web_server"] 
  end
  
end

if java==""
   case node["platform"]
      when "centos","redhat","fedora"
         yum_package "java-1.6.0-openjdk" do
	    action :install
	 end
      when "ubuntu","debian"
         apt_package "openjdk-6-jre" do
	    action :install
	 end
   end
end


directory node["tomcat"]["tomcat_home"] do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end


remote_file "/tmp/tomcat.tar" do
 source tomcat_tar
#  not_if {File.directory? tomcat_dir}
end

execute "untar-tomcat" do
  cwd node['tomcat']['tomcat_home']
  command "tar --strip-components 1 -xf /tmp/tomcat.tar"
end

#	script "install" do
#	  interpreter "bash"
#	  user "root"
#	  cwd "/opt"
#	  code <<-EOH
#	  cd $(dirname #{tomcat_dir})
#	  rm -rf /tmp/apache-tomcat-6.*
#	  tar xvf /tmp/tomcat.tar
#	  mv apache-tomcat-6.* #{tomcat_dir}
#	  EOH
#	  not_if {File.directory? tomcat_dir}
#	end

file "/tmp/tomcat.tar" do
  action :delete
  only_if { File.exists? "/tmp/tomcat.tar" }
end

template node['tomcat']['tomcat_home'] + '/conf/server.xml' do
  source 'server.xml.erb'
  mode 0755
  owner 'root'
  group 'root'
  variables(
    :tomcat_port     => node["tomcat"]["port"],
    :tomcat_sslport  => node["tomcat"]["ssl_port"],
    :tomcat_ajpport  => node["tomcat"]["ajp_port"],
    :tomcat_shutdown_port  => node["tomcat"]["shutdown_port"]
    )
end

tomcat_erb_file=""
case node["platform"]
      when "centos","redhat","fedora"
          tomcat_erb_file="tomcat.centos.erb"
      when "debian","ubuntu"
          tomcat_erb_file="tomcat.deb.erb"
end

template "/etc/init.d/tomcat" do
  source tomcat_erb_file
  mode 0755
  owner 'root'
  group 'root'
  variables(
    :tomcat_home     => node["tomcat"]["tomcat_home"]
  )
end


service "tomcat" do
  service_name "tomcat"
    case node["platform"]
      when "centos","redhat","fedora"
          supports :restart => true, :status => true
      when "debian","ubuntu"
          supports :restart => true, :reload => true, :status => true
    end
  action [:enable, :restart]
end


#include_recipe "tomcat::tomcat_start"
