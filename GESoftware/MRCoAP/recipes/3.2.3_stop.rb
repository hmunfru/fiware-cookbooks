#
# Cookbook Name:: MRCoAP Protocol Adapter GE
# Recipe:: 3.2.3_stop
#
# Copyright 2014, SAP
#
# All rights reserved - Do Not Redistribute
#

bash "run" do
  user "root"
  code <<-EOH
#!/bin/bash

cd /root/coap
pkill -f 'java -jar'

  EOH

end

