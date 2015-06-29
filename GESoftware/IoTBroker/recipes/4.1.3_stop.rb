#
# Cookbook Name:: IoTBroker
# Recipe:: 4.1.3_stop
#
# Copyright 2014, NEC
#
# All rights reserved - Do Not Redistribute
#

bash "run" do
  user "root"
  code <<-EOH
#!/bin/bash

cd /root/IoTBroker/IoTBroker_FIWARE_4.1.3
./unix64_stop-IoTBroker.sh

  EOH

end

