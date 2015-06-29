# SLS cookbook
# recipe: storm_config 
#
# This recipe is used to config the Storm cluster
#

# search
#storm_nimbus = search(:node, "role:sls-standalone AND role:#{node['storm']['cluster_role']}").first
storm_nimbus = "#{node['storm']['storm_nimbus']}"

install_dir = "#{node['storm']['install_dir']}/storm-#{node['storm']['version']}"

#setup storm group
group "#{node['sls']['group']}"


# setup directories
%w{install_dir local_dir log_dir}.each do |name|
  directory node['storm'][name] do
    owner "#{node['sls']['user']}"
    group "#{node['sls']['group']}"
    action :create
    recursive true
  end
end

# Install storm (we assume it is already installed in the SLS image)
unless ::File.exist?("#{node['storm']['install_dir']}/storm-#{node['storm']['version']}")

   execute "wget-storm" do
     cwd "#{node['storm']['install_dir']}"
     command "wget http://repositories.testbed.fi-ware.org/webdav/sls/storm-0.9.0-wip16.zip"
  end

  execute "unzip-Storm" do
    cwd "#{node['storm']['install_dir']}" 
    user "#{node['sls']['user']}"
    group "#{node['sls']['group']}"
    command "unzip -o storm-0.9.0-wip16.zip; rm -f storm-0.9.0-wip16.zip"
  end
  
  link "/opt/storm" do
     to "#{node['storm']['install_dir']}/storm-#{node['storm']['version']}"
  end

   # create a link from the specific version to a generic current folder
   link "#{node['storm']['install_dir']}/current" do
        to "#{node['storm']['install_dir']}/storm-#{node['storm']['version']}"
   end

   execute "link-stormlogs" do
      command "rm -rf #{node['storm']['install_dir']}/storm-#{node['storm']['version']}/logs"
   end   

   link "#{node['storm']['install_dir']}/current/logs" do
        to "#{node['storm']['log_dir']}"
   end
end

unless ::File.exist?("/var/run")
  directory "/var/run" do
    owner node["sls"]["user"]
    group node["sls"]["group"]
    mode 00755
    action :create
  end
end

unless ::File.exist?("/var/run/storm")
  directory "/var/run/storm" do
    owner node["sls"]["user"]
    group node["sls"]["group"]
    mode 00755
    action :create
  end
end

execute "copy-SLSTopologyJar" do
     user "#{node['sls']['user']}"
     group "#{node['sls']['group']}"
     command "cp -r #{node[:sls][:install_dir]}/topologies /opt/storm"
end

execute "copy-SLSTopologyConf" do
     user "#{node['sls']['user']}"
     group "#{node['sls']['group']}"
     command "cp #{node[:sls][:install_dir]}/conf/* /opt/storm/conf"
end

execute "copy-SLSTopologyAdmin" do
     user "#{node['sls']['user']}"
     group "#{node['sls']['group']}"
     command "cp -r #{node[:sls][:install_dir]}/admin /opt/storm"
end

#execute "copy-SLSTopologyScripts" do
#     user "#{node['sls']['user']}"
#     group "#{node['sls']['group']}"
#     command "cp #{node[:sls][:install_dir]}/scripts/* /etc/init.d"
#end

# storm.yaml
template "/opt/storm/conf/storm.yaml" do
  source "storm.yaml.erb"
  mode 00644
  variables(
    :nimbus => storm_nimbus,
    #:zookeeper_quorum => zookeeper_quorum
  )
end

template "/opt/storm/conf/ServiceLevelSIEM.conf" do
    source "ServiceLevelSIEM.conf.erb"
    mode 0777
    owner "root"
    group "root"
end

#template "#{node[:storm][:home_dir]}/conf/storm.simple.yaml" do
#  source "storm.yaml.simple.erb"
#  owner "root"
#  group "root"
#  mode "0644"
#  variables({ :nimbus_ip => node[:storm][:nimbus][:ip],
#                :zookeeper_ips => node[:storm][:zookeeper_ips],
#                :supervisor_ports => node[:storm][:supervisor][:ports]
#    })
#end

# sets up storm user profile
template "#{node['sls']['home']}/addProfile" do
  owner  "root"
  group  "root"
  source "addProfile.erb"
  mode   00644
  variables(
    :storm_dir => "/opt/storm"
  )
end

execute "add-STORM_HOME" do
  cwd node["sls"]["home"]
  command "cat addProfile >> /root/.profile; rm -f addProfile"
end

template "#{install_dir}/bin/killstorm" do
  source  "killstorm.erb"
  owner "#{node['sls']['user']}" 
  group "#{node['sls']['group']}" 
  mode  00755
  variables(
    :log_dir => "#{node['storm']['log_dir']}"
  )
end


