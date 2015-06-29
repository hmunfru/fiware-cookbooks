directory "#{node['tomcat']['webapp_dir']}/prrsWebConsole" do
  action : delete
end

file "#{node['tomcat']['webapp_dir']}/prrsWebConsole.war" do
  action : delete
end

mysql_database 'prrscontextmanager' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :drop
end

mysql_database 'securityrepository' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :drop
end

