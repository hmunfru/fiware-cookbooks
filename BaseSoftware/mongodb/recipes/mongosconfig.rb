shard_nodes = search(
      :node,
     "mongodb_cluster_name:#{node['mongodb']['cluster_name']} AND \
     recipes:mongodbshard\\:\\:2.2.3_install AND \
     chef_environment:#{node.chef_environment}"
    )

Chef::Log.warn(shard_nodes.length)

  Chef::Log.warn("config_sharding")
    Chef::Log.warn("g")

          Chef::ResourceDefinitionList::MongoDB.configure_shards(node, shard_nodes)
          #MongoDB.configure_sharded_collections(node, node['mongodb']['sharded_collections'])
