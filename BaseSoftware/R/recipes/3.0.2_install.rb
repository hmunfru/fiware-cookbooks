#
# Cookbook Name:: R
# Recipe:: 3.0.2_install
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe "yum::epel"

package "R" do
  version "3.0.2-1.el6"
  action :install
end

