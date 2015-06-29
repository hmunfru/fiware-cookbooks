#
# Cookbook Name:: MRCoAP Protocol Adapter GE
# Recipe:: 3.2.3_install
#
# Copyright 2014, SAP
#
# All rights reserved - Do Not Redistribute
#

package "unzip" do
   action :install
end


#add install repository to apt
execute "add-apt-repository ppa:webupd8team/java" do  
	action :run
end

#update apt repository
execute "apt-get update" do  
	action :run
end

package "debconf" do
        action :install
		options "--yes"
end

bash "installscript" do
  user "root"
  code <<-EOH
#!/bin/bash

#create parent directory
cd /root
mkdir coap

#download archive
cd coap
wget --no-check-certificate  https://forge.fi-ware.org/frs/download.php/1167/IOT-MRCoAP-3.2.3.zip

#go to directory of zip
cd /root/coap

#unzip
unzip IOT-MRCoAP-3.2.3.zip

#make executable executable
cd /root/coap/fwcoapmradapter_jar
chmod +x run.sh

#get additional dependencies
cd /root/coap/fwcoapmradapter_jar
mkdir libs
cd libs
wget http://78.47.89.18/libs.zip
unzip libs.zip

#start the MRCoAP
cd /root/coap/fwcoapmradapter_jar
java -cp 'fwcoapmradapter.jar:libs/*' com.sap.research.fiware.MRCoAPAdapter.fwCoAPMRAdapter -ngsi9 'http://localhost:80/post.php' -ngsi10 'http://localhost:80/post.php' -mrgateway '0000:0000:0000:0001' -mrnetwork 'fc00:db8:5::' -port '8080'

  EOH

end
