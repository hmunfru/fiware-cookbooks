#
# Cookbook Name:: metadatapreproc
# Recipe:: default
#
# Copyright 2014, Siemens AG
#
# All rights reserved - Do Not Redistribute
#

service "mdppd" do
	service_name "mdppd"
  action :start
end

