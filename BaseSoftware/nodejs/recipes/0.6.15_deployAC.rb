node.default['nodejs']['application'] = "nodejstest" 
nodeapp="#{node["nodejs"]["application"]}"
if #{node["nodejs"]["url_repo_git"]} != null
  
#{node["git"]["application"] =#{nodeapp}
#{node["git"]["url_repository"] = #{node["nodejs"]["url_repo_git"]} 

  include_recipe "git::1.7_deployAC"
end 

nodejs_server "#{nodeapp}" do
    script "#{node["git"]["default_folder"]}#{nodeapp}/#{nodeapp}/server.js" # mandatory
    user "root" # default : root
    dependency [] # default []. Will be installed with npm before starting the server
    args "" # default ""
    action :start # Will start a node server. In [stop,start,restart]
end
