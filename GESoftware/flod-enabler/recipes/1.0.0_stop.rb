
##################################################################################
### File Name    : 1.0.0_stop.rb                                               ###
### Description  : Recipe to Stop flod enabler on ubuntu OS.                   ###
### Version      : 1.0.0                                                       ###
### Author       : Orange Labs P&S - India, Pallav Gupta & Antriksh Mathur     ###
### Creation On  : 27-05-2014                                                  ###
### Modified On  : None                                                        ###
### Modification : None                                                        ###
##################################################################################


## checking virtuoso installation
return if ! File.exists?("/etc/init.d/virtuoso");

## stopping virtuoso
service "virtuoso" do
  service_name "virtuoso"
  supports [:restart, :reload, :status, :stop]
  action [:stop]
end

## stopping SemanticWrapper
bash "Stopping SemanticWrapper..." do
  user "root"
  cwd "/root/SemanticWrapper"
  code <<-EOH
  ./stop.sh &
  EOH
only_if "test -d /root/SemanticWrapper"
end

## stopping PSFrontEnd
bash "Stopping PSFrontEnd..." do
  user "root"
  cwd "/root/PSFrontEnd"
  code <<-EOH
  ./stop.sh &
  EOH
only_if "test -d /root/PSFrontEnd"
end
