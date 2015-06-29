
#stop apache service
service "apache2" do
  action :stop
end

#stop subversion service
service "subversion" do
  action :stop
end

#delete repo dir
execute 'rm -rf repo' do
  command "rm -rf #{node['subversion']['repo_dir']}"
end

#delete htpasswd file
execute 'rm -rf htpasswd' do
  command "rm -rf #{node['subversion']['repo_dir']}/htpasswd"
end

#delete authz file
execute 'rm -rf authz' do
  command "rm -rf #{node['subversion']['repo_dir']}/authz"
end

#remove
package 'subversion' do
  action :remove
end

package 'subversion-devel' do
  action :remove
end

package 'subversion-perl' do
  action :remove
end

apache_module 'dav_svn' do
  enable false
end 

apache_module 'svn_authz' do
  filename "mod_authz_svn.so"
  identifier "authz_svn_module"	
  enable false
end

apache_site 'subversion.conf' do
  enable false
end



