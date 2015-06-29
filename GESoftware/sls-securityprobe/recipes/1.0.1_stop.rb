#Cookbook Name:: SecurityProbe 
# Recipe:: default
#
# Copyright 2014, ATOS
#
#

service "ossim-agent" do
  action :stop
end


