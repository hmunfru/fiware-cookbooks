
if  node["mongodbconfig"] != nil
  if node["mongodbconfig"]["mongodb_cluster_name"] !=  nil
    node.default['mongodb']['mongodb_cluster_name'] = node["mongodbconfig"]["mongodb_cluster_name"] 
     end
  if node["mongodbconfig"]["cluster_name"] !=  nil
    node.default['mongodb']['cluster_name'] = node["mongodbconfig"]['cluster_name']
  end
 
end


node.default['mongodb']['port'] = "27019"
print node['mongodb']['mongodb_cluster_name']
print node['mongodb']['cluster_name']
include_recipe "mongodb::configserver"
