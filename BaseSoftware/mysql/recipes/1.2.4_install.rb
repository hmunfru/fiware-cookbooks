
if  node["mysql"] != nil

  if node["mysql"]["database_server_role"] !=  nil
    node.default['mysql']['database_server_role'] = node["mysql"]["database_server_role"] 
  end
  
end

if platform?("redhat", "centos", "fedora")
	include_recipe "mysql::server"
end

if platform?("debian", "ubuntu")
	include_recipe "mysql::server2"
end



