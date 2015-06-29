
#node_npm 'node' do
 #   action :install
#end

node_server 'henar' do
    script "/opt/nodejs/node_modules/nodejstest/server.js" # mandatory
    user "root" # default : root
    dependency [] # default []. Will be installed with npm before starting the server
    args "" # default ""
    action :start # Will start a node server. In [stop,start,restart]
end 
#node_server 'node' do
 # script 'opt/nodejs/node_modules/nodejstest/server.js'
 # action :start
#end




#node_server "my_node_server do
 #       script "/opt/nodejstest/server.js" # mandatory
  #      user "root" # default : root
  #      dependency ["required","node","modules"] # default []. Will be installed with npm before starting the server
  #      args "" # default ""
  #      action :start # Will start a node server. In [stop,start,restart]
  #  end
