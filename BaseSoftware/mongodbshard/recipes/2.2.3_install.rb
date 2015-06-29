if  node["mongodbshard"] != nil
if node["mongodbshard"]["cluster_name"] !=  nil
  node.default['mongodb']['cluster_name'] = node["mongodbshard"]['cluster_name']
end
end
node.default['mongodb']['port'] = "27018"
include_recipe "mongodb::shard"
