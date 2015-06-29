
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

#remove subversion
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

#remove java / tomcat
package 'java' do
  action :remove
end

package 'tomcat' do
  action :remove
end

#remove redirect_proxy
apache_module 'mod_proxy' do
  enable false
end 

apache_module 'mod_proxy_http' do
  enable false
end 

apache_site 'redirect_proxy.conf' do
  enable false
end

