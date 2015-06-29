#
# Cookbook Name:: metadatapreproc
# Recipe:: configure
#
# Copyright 2014, Siemens AG
#
# All rights reserved - Do Not Redistribute
#

log "*** Generate mdpp.conf setting parameter 'LocalAddr' to current value ***"
log "*** Further configurations of each instance of MDPP can to be done via REST *** (-;"

# Query own ip-address and generate mdpp.conf 


bash "update conf_ipaddr" do
   user "root"
   cwd "/usr/local/bin/mdpp/"

   code <<-EOH
	ipaddr=$(ifconfig eth0 | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
	#sed -i "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/$ipaddr/" mdpp.conf 

        echo "[mdpp]\nLocalAddr = $ipaddr\nDeviceType = RestXmlConverter\nLocalRestUrl = http://*:8080/mdp\n" > mdpp.conf


   EOH

end

service "mdppd" do
  service_name "mdppd"
  action :restart
end

