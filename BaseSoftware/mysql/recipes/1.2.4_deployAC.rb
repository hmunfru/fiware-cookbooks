
if  node["mysql"] != nil

  if node["mysql"]["database"] !=  nil
    node.default['mysql']['database'] = node["mysql"]["database"] 
  end
    

  if node["mysql"]["user"] !=  nil
    node.default['mysql']['user'] = node["tomcat"]['application_name']
  end
  
end


directory "/opt/mysql" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

file "/opt/mysql/database.sql" do
  action :delete
  only_if { File.exists? "/tmp/tomcat.tar" }
end

  template "/opt/mysql/database.sql" do
    source "database.sql.erb"
    owner "root"
    group node['mysql']['root_group']
    mode "0600"
    variables(
        :database => "#{ node['mysql']['database']}"
      )
  end

  
   execute "mysql-install-database" do
      command "#{node['mysql']['mysql_bin']} -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }\"#{node['mysql']['server_root_password']}\" < '/opt/mysql/database.sql'"
      action :run
    end
 



