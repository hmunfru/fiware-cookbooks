include_recipe "sls::ossim_server_config"
include_recipe "sls::storm_config"

service "alienvault-idm" do
  action :restart
end

service "ossim-framework" do
  action :restart
end

service "ossim-server" do
  action :restart
end

service "ossim-socat" do
  action :restart
end

service "ossim-agent" do
  action :restart
end

service "storm-nimbus" do
  action :restart
end

service "storm-supervisor" do
  action :restart
end

service "storm-ui" do
  action :restart
end

#include_recipe "sls::restartSLSTopology"


