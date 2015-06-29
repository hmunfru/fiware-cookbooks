include_recipe "mongodb::2.2.3_install"

directory "/data" do
  owner "mongod"
  group "mongod"
  mode 0755 
  action :create
end

directory "/data/mongodb" do
  owner "mongod"
  group "mongod"
  mode 0755 
  action :create
end

# disable and stop the default mongodb instance
service "mongodb" do
  supports :status => true, :restart => true
  action [:disable, :stop]
end


# we are not starting the shard service with the --shardsvr
# commandline option because right now this only changes the port it's
# running on, and we are overwriting this port anyway.
mongodb_instance "mongod_ct" do
  port         node['mongodb']['port']
  logpath      node['mongodb']['logpath']
  dbpath       '/data/mongodb'
  shardsvr     false
  smallfiles   true

end

