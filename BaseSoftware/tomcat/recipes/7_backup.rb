#
# Cookbook Name:: tomcat
# Recipe:: 7_backup
#
# Copyright 2011, Telefonica I+D
#
# Author: Jesus M. Movilla
#
# All rights reserved - Do Not Redistribute

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

