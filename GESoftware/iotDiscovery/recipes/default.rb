#
# Cookbook Name:: iotDiscovery
# Recipe:: default
#
# Copyright 2014, UNIVERSITY OF SURREY
#
# All rights reserved - Do Not Redistribute
#

if platform?("ubuntu")
        log "Ubuntu detected, installing IoT Discovery..."

#include_recipe 'iotDiscovery::4.1.1_configure'
include_recipe "iotDiscovery::4.1.1_install"
#include_recipe "iotDiscovery::4.1.1_start"
#include_recipe "iotDiscovery::4.1.1_stop"
#include_recipe "iotDiscovery::4.1.1_uninstall"

else
        Chef::Application.fatal!("This chef recipe for installing IoT Discovery supports only Ubuntu")
end
