include_recipe "orion-dbcluster::fiware_repo"

package node[:oriondbcluster][:package_name] do
  version "0.6.0-dev"
  action :install
end

shardnode = search(
  :node,
  "mongodb_cluster_name:#{node['mongodb']['cluster_name']} AND \
   recipes:mongodbshard\\:\\:2.2.3_install  AND \
   chef_environment:#{node.chef_environment}"
)


# context init
template "/opt/contextini.sh" do
    action :create
    source "contextbroker.init.erb"
    group "root"
    owner "root"
    mode "777"
end

bash "install_something" do
  user "root"
  code <<-EOH
    ./opt/contextini.sh > /opt/contextbroker.out
  EOH
end

bash "start_context_broker" do
  user "root"
  code <<-EOH
    /etc/init.d/contextBroker start
  EOH
end
