#
# Cookbook Name:: augmentedreality
# Recipe:: start
#
# Copyright 2014, CIE, University of Oulu
#
# All rights reserved - Do Not Redistribute
#

service node["apache"]["service_name"] do
	action :start
end
