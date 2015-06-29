
##################################################################################
### File Name    : 1.0.0_start.rb                                              ###
### Description  : Recipe to Start flod enabler on ubuntu OS.                  ###
### Version      : 1.0.0                                                       ###
### Author       : Orange Labs P&S - India, Pallav Gupta & Antriksh Mathur     ###
### Creation On  : 26-05-2014                                                  ###
### Modified On  : None                                                        ###
### Modification : None                                                        ###
##################################################################################


## checking virtuoso installation
return if ! File.exists?("/etc/init.d/virtuoso");

## This starts virtuoso
 bash "Starting virtuoso..." do
  user "root"
  code <<-EOH
  nohup /etc/init.d/virtuoso start </dev/null &>/dev/null &
  EOH
end


## This updates rc.d
execute "Updating rc.d" do
  command "update-rc.d virtuoso defaults"
  action :run
end

## This starts SemanticWrapper
bash "Starting SemanticWrapper..." do
  user "root"
  cwd "/root"
  code <<-EOH
  cd SemanticWrapper
  ./start.sh &
  EOH
end

## This starts PSFrontEnd
bash "Starting PSFrontEnd..." do
  user "root"
  cwd "/root"
  code <<-EOH
  cd PSFrontEnd
  ./start.sh &
  killall -9 chef-client
  EOH
end

