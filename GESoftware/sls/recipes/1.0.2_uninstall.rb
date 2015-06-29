
include_recipe "sls::undeploy-supervisor"
include_recipe "sls::undeploy-nimbus"
include_recipe "sls::undeploy-default"
include_recipe "sls::undeploy-zookeeper"

service "ossim-agent" do
  action :stop
end

service "ossim-server" do
  action :stop
end

service "ossim-socat" do
  action :stop
end

service "ossim-framework" do
  action :stop
end

service "alienvault-idm" do
  action :stop
end

