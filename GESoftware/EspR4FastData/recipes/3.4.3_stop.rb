#
# Cookbook Name:: EspR4FastData
# Recipe:: default
#
# Copyright 2014, ORANGE
#
# All rights reserved - Do Not Redistribute
#

bash "EspR4FastDataStop" do
  user "root"
  cwd "/tmp"
  code <<-EOH

#!/bin/bash
. /etc/profile.d/jre.sh
. /etc/profile.d/tomcat.sh

$CATALINA_HOME/bin/shutdown.sh

  EOH
end
