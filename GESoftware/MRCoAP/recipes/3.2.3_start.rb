#
# Cookbook Name:: MRCoAP Protocol Adapter GE
# Recipe:: 3.2.3_start
#
# Copyright 2014, SAP
#
# All rights reserved - Do Not Redistribute
#

bash "run" do
  user "root"
  code <<-EOH
#!/bin/bash

cd /root/coap/fwcoapmradapter_jar
java -cp 'fwcoapmradapter.jar:libs/*' com.sap.research.fiware.MRCoAPAdapter.fwCoAPMRAdapter -ngsi9 'http://localhost:80/post.php' -ngsi10 'http://localhost:80/post.php' -mrgateway '0000:0000:0000:0001' -mrnetwork 'fc00:db8:5::' -port '8080'

  EOH

end

