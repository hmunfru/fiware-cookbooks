# generate all passwords
#node.set_unless['mysql']['server_debian_password'] = secure_password
#node.set_unless['mysql']['server_root_password']   = secure_password
#node.set_unless['mysql']['server_repl_password']   = secure_password
node.set_unless['mysql']['server_debian_password'] = 'mysql321go'
node.set_unless['mysql']['server_root_password']   = 'mysql321go'
node.set_unless['mysql']['server_repl_password']   = 'mysql321go'

bash "evite passwords" do
  code <<-EOH
  debconf-set-selections <<< "mysql-server mysql-server/root_password password #{node['mysql']['server_root_password']}"
  debconf-set-selections <<< "mysql-server mysql-server/root_password_again password #{node['mysql']['server_root_password']}"
  EOH
end

package "mysql-server" do
  action :install
end

grants_path = node['mysql']['grants_path']

begin
  t = resources("template[#{grants_path}]")
rescue
  Chef::Log.info("Could not find previously defined grants.sql resource")
  t = template grants_path do
    source "grants.sql.erb"
    owner "root"
    group node['mysql']['root_group']
    mode "0600"
    action :create
  end
end

execute "mysql-install-privileges" do
  command "#{node['mysql']['mysql_bin']} -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }\"#{node['mysql']['server_root_password']}\" < #{grants_path}"
  action :nothing
end


service "mysql" do
	action :restart
end
