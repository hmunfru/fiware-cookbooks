#
# Cookbook Name:: MRCoAP Protocol Adapter GE
# Recipe:: 3.2.3_uninstall
#
# Copyright 2014, SAP
#
# All rights reserved - Do Not Redistribute
#

bash "run" do
  user "root"
  code <<-EOH
#!/bin/bash


#stop the software
pkill -f 'java -jar'

#wait a bit
sleep 3

#remove the coap folder and all its contents
cd /root
rm -rf coap


  EOH

end

