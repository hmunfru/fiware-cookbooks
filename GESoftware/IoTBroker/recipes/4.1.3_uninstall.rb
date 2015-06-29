#
# Cookbook Name:: IoTBroker
# Recipe:: 4.1.3_uninstall
#
# Copyright 2014, NEC
#
# All rights reserved - Do Not Redistribute
#

bash "run" do
  user "root"
  code <<-EOH
#!/bin/bash


#stop the software
cd /root/IoTBroker/IoTBroker_FIWARE_4.1.3
./unix64_stop-IoTBroker.sh

#wait a bit
sleep 3

#remove the IoTBroker folder and all its contents
cd /root
rm -r IoTBroker


  EOH

end

