
##################################################################################
### File Name    : 1.0.0_uninstall.rb                                          ###
### Description  : Recipe to uninstall flod enabler on ubuntu OS               ###
### Version      : 1.0.0                                                       ###
### Author       : Orange Labs P&S - India, Pallav Gupta & Antriksh Mathur     ###
### Creation On  : 22-05-2014                                                  ###
### Modified On  : None                                                        ###
### Modification : None                                                        ###
##################################################################################


## Stopping if flod enabler
include_recipe "flod-enabler::1.0.0_stop"


## Removing virtuoso service
file "/etc/init.d/virtuoso" do
  owner "root"
  group "root"
  action :delete
end

## Removing virtuoso folder
bash "Removing virtuoso..." do
  user "root"
  cwd "/root/Virtuoso/virtuoso-opensource-6.1.4"
  code <<-EOH
  make unistall
  cd ../..
  rm -rf Virtuoso 
 EOH
end

## Removing SemanticWrapper folder
bash "Removing SemanticWrapper" do
  user "root"
  cwd "/root"
  code <<-EOH
  rm -rf SemanticWrapper.* SemanticWrapper
 EOH
end

## Removing PSFrontEnd folder
bash "Removing PSFrontEnd" do
  user "root"
  cwd "/root"
  code <<-EOH
  rm -rf PSFrontEnd.* PSFrontEnd
 EOH
end
