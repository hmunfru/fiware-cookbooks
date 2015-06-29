include_recipe "git::1.7_install"
include_recipe "nodejs::default"
if #{node["nodejs"]["application"]} != null
  nodeapp="#{node["nodejs"]["application"]}"
end

if #{node["nodejs"]["url_repo_git"]} != null
  include_recipe "git::1.7_deployAC"
end 

nodejs_server "#{nodeapp}" do
    script "#{node["git"]["default_folder"]}#{nodeapp}/#{nodeapp}/server.js" # mandatory
    user "root" # default : root
    dependency [] # default []. Will be installed with npm before starting the server
    args "" # default ""
    action :start # Will start a node server. In [stop,start,restart]
end
