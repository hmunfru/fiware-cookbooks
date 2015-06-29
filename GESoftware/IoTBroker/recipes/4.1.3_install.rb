#
# Cookbook Name:: IoTBroker
# Recipe:: 4.1.3_install
#
# Copyright 2014, NEC
#
# All rights reserved - Do Not Redistribute
#

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :run
end

package "openjdk-7-jre-headless" do
   action :install
end


package "unzip" do
   action :install
end

bash "installscript" do
  user "root"
  code <<-EOH
#!/bin/bash

#check if already installed
if [ -d "/root/IoTBroker/IoTBroker_FIWARE_4.1.3" ]
then
        echo '/root/IoTBroker/IoTBroker_FIWARE_4.1.3 already exists; starting it.'
else
	#install IoT Broker
	
	#create parent directory
	cd /root
	mkdir IoTBroker

	#download archive
	cd IoTBroker
	wget --no-check-certificate  https://forge.fi-ware.org/frs/download.php/1557/IoTBroker_FIWARE_4.1.3.zip

	#go to directory of zip
	cd /root/IoTBroker

	#unzip the broker
	unzip IoTBroker_FIWARE_4.1.3.zip

	#make executables executable
	cd /root/IoTBroker/IoTBroker_FIWARE_4.1.3
	chmod +x unix64_start-IoTBroker.sh
	chmod +x unix64_start-IoTBroker_as_Demon.sh
	chmod +x unix64_stop-IoTBroker.sh

	#remove archive
	cd /root/IoTBroker
	rm IoTBroker_FIWARE_4.1.3.zip

fi


#start the broker
cd /root/IoTBroker/IoTBroker_FIWARE_4.1.3
./unix64_start-IoTBroker_as_Demon.sh

  EOH

end

