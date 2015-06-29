#
# Cookbook Name:: tomcat
# Recipe:: 5.5_backup
#
# Copyright 2011, Telefonica I+D
#
# Author: Jesus M. Movilla
#
# All rights reserved - Do Not Redistribute

#script "Tomcat stop" do
#  interpreter "bash"
#  user "root"
#  cwd "/tmp"
#  code <<-EOH
#  if [ -f /opt/apache-tomcat/bin/shutdown.sh ] 
#  then
#  export JRE_HOME=/usr/lib/jvm/java-6-openjdk/jre
#  /opt/apache-tomcat/bin/shutdown.sh
#  fi
#  EOH
#end

script "backup_tomcat" do
  interpreter "bash"
  user "root"
  only_if "test -d #{node[:tomcat][:tomcat_home]}"
  cwd #{node[:tomcat][:tomcat_home]}
  code <<-EOH
  if [ -d /opt/apache-tomcat ]
  then
  tar cvf /tmp/conf.tar conf/Catalina/localhost --exclude "conf/Catalina/localhost/*manager.xml"
  #tar cvf /tmp/webapps.tar webapps/
  #tar cvf /tmp/logs.tar logs/
  cp lib/postgresql* /tmp
  fi
  if [ -f cp lib/postgresql* ]
  then
  cp lib/postgresql* /tmp
  fi
  EOH
end

#script "Tomcat start" do
#  interpreter "bash"
#  user "root"
#  cwd "/tmp"
#  code <<-EOH
#  if [ -f /opt/apache-tomcat/bin/startup.sh ] 
#  then
#  export JRE_HOME=/usr/lib/jvm/java-6-openjdk/jre 
#  /opt/apache-tomcat/bin/startup.sh
#  fi 
#  EOH
#end
