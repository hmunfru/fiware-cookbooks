#
# Cookbook Name:: EspR4FastData
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "EspR4FastDataUninstall" do
  user "root"
  cwd "/tmp"
  code <<-EOH

#!/bin/bash
. /etc/profile.d/jre.sh
. /etc/profile.d/tomcat.sh

$CATALINA_HOME/bin/shutdown.sh

rm -rf /usr/local/tomcat6
rm -rf /usr/local/jre6
rm -f /etc/profile.d/jre.sh
rm -f /etc/profile.d/tomcat.sh
rm -f /etc/init/tomcat.conf
rm -f /tmp/*EspR4FastData*
rm -f /root/EspR4FastDataSanityCheck.jar
  EOH
end
