

include_recipe 'java'

application node['svnwebadmin']['application_name'] do 
  path node['svnwebadmin']['application_path']
  owner node['tomcat']['user']
  group node['tomcat']['group']
  repository node['svnwebadmin']['war_uri']
  
  scm_provider Chef::Provider::RemoteFile::Deploy

  java_webapp

  tomcat
end


include_recipe 'subversion::1.1.0_install'

include_recipe 'apache2::mod_proxy'
include_recipe 'apache2::mod_proxy_http'


web_app 'redirect_proxy' do
  template    'redirect_proxy.load.erb'
  notifies    'restart[apache2]'
end

