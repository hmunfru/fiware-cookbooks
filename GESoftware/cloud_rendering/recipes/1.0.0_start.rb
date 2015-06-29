# Cookbook Name:: cloud-rendering
# Recipe:: start

execute "start service" do
  action :run
  user "root"
  environment ({'NODE_ENV' => 'dev'})
  cwd "/usr/local/src/cloud-rendering/service"
  command "/etc/init.d/cloud-rendering-service.sh start"
end
