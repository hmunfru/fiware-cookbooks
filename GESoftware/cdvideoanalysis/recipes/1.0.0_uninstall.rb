#
# Cookbook Name:: cdvideoanalysis
# Recipe:: default
#
# Copyright 2013,  Siemens AG
#
# All rights reserved - Do Not Redistribute
#


# Uninstalling CDVA GE


bash "remove cdva-files" do
	user "root"

  code <<-EOH
	PATH_INSTALL_CODOAN=/usr/local/bin/codoan
	PATH_INSTALL_SCRIPT=/etc/init.d

	service codoand stop

	rm -rf $PATH_INSTALL_CODOAN
	rm -f $PATH_INSTALL_SCRIPT/codoand

	update-rc.d codoand remove

	exit 0
   EOH
end

