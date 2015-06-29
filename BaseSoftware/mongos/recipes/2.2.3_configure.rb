if node["mongos"] != nil
if node["mongos"]["mongodb_cluster_name"] !=  nil
  node.default['mongodb']['mongodb_cluster_name'] = node["mongos"]["mongodb_cluster_name"]
end
if node["mongos"]["cluster_name"] !=  nil
  node.default['mongodb']['cluster_name'] = node["mongos"]['cluster_name']
end
end
include_recipe "mongodb::mongosconfig"
service "mongos" do
  action [:reload, :restart]
end

