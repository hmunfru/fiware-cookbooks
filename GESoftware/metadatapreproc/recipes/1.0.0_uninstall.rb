#
# Cookbook Name:: metadatapreproc
# Recipe:: default
#
# Copyright 2014,  Siemens AG
#
# All rights reserved - Do Not Redistribute
#


# Uninstalling CDVA GE


bash "remove mdpp-files" do
	user "root"

  code <<-EOH
	PATH_INSTALL_MDPP=/usr/local/bin/mdpp
	PATH_INSTALL_SCRIPT=/etc/init.d

	service mdppd stop

	rm -rf $PATH_INSTALL_MDPP
	rm -f $PATH_INSTALL_SCRIPT/mdppd

	update-rc.d mdppd remove

	exit 0
   EOH
end

