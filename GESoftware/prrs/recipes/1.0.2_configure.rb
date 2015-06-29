
# PRRS Configuration
template "#{node['prrs']['home']}/PRRS-Karaf-3.3.3/PRRS_installation/conf/sdmanager.conf" do
  source "sdmanager.erb"
  mode 0644
  owner node["prrs"]["user"] 
  group node["prrs"]["group"] 
  notifies :restart,"service[KARAF-service]"
  variables({
        :activateDownload => node['prrs']['activateDownload'],
        :activateLogger_FIWARE => node['prrs']['activateLogger_FIWARE'],
        :syslogServer => node['prrs']['syslogServer'],
        :syslogPort => node['prrs']['syslogPort'],
        :database_user => node['prrs']['database_user'],
        :database_password  => node['prrs']['database_password'],
        :database_url => node['prrs']['database_url'],
        :database_contextdb_url => node['prrs']['database_contextdb_url'],
        :database_secrepo_url => node['prrs']['database_secrepo_url'],
        :marketplace_url => node['prrs']['marketplace_url'],
        :collection_name  => node['prrs']['collection_name'],
        :marketplace_user => node['prrs']['marketplace_user'],
        :marketplace_passwd => node['prrs']['marketplace_passwd'],
        :contextmonitor_startTime => node['prrs']['contextmonitor_startTime'],
        :contextmonitor_pollTime => node['prrs']['contextmonitor_pollTime']
  })
end


