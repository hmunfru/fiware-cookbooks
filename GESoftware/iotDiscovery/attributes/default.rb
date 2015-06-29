#java cookbook
node.override['java']['oracle']['accept_oracle_download_terms'] = true
node.override['java']['accept_license_agreement'] = true
node.override['java']['set_etc_environment'] = true
node.default['java']['install_flavor'] = 'oracle'
node.default['java']['jdk_version'] = '8'

#mysql cookbook
#node.default['mysql']['server_root_password'] = 'root'
#node.default['mysql']['version'] = '5.5'

#tomcat cookbook
node.default["tomcat"]["base_version"]= '7'
node.default["tomcat"]["catalina_options"]= '-Djava.net.preferIPv4Stack=true'

