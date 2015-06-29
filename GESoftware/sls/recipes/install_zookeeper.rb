
install_dir = "#{node['zookeeper']['install_dir']}/zookeeper-#{node['zookeeper']['version']}"

unless ::File.exist?("#{node['zookeeper']['install_dir']}/zookeeper-#{node['zookeeper']['version']}")
  execute "wget-zookeeper" do
    cwd "#{node['zookeeper']['install_dir']}"
    command "wget http://repositories.testbed.fi-ware.org/webdav/sls/zookeeper-3.4.5.tar.gz"
  end

  execute "untar-zookeeper" do
    cwd "#{node['zookeeper']['install_dir']}" 
    command "tar -zxvf zookeeper-3.4.5.tar.gz; rm -f zookeeper-3.4.5.tar.gz" 
  end

  link "/opt/zookeeper" do
     to "#{node['zookeeper']['install_dir']}/zookeeper-#{node['zookeeper']['version']}"
  end
end

cookbook_file "#{node['zookeeper']['install_dir']}/zookeeper-3.4.5/conf/zoo.cfg" do
   source "zoo.cfg"
   mode 0755
   owner node["sls"]["user"]
   group node["sls"]["group"]
end

directory "#{node['zookeeper']['log_dir']}" do
  owner node["sls"]["user"]
  group node["sls"]["group"]
  mode 00755
  action :create
end

execute "myid-zookeeper" do
  command "echo 1 > #{node['zookeeper']['log_dir']}/myid" 
end

execute "sv-backup" do
  command "cp -pf /usr/bin/sv /usr/bin/sv.backup"
  only_if "test -f /usr/bin/sv"
end

initfile = ::File.join( '/etc', 'init.d', 'zookeeper')
::File.unlink(initfile) if ::File.symlink?(initfile)

# runit service
runit_service "zookeeper" do
    options({
      :install_dir => install_dir,
      :log_dir => node['zookeeper']['log_dir'],
      :user => node['sls']['user']
    })
end

execute "sv-recover" do
  command "mv -f /usr/bin/sv.backup /usr/bin/sv"
  only_if "test -f /usr/bin/sv.backup"
end

#execute "reload_zookeeper" do
#  command "sv reload zookeeper"
#  action :nothing
#end

#service "zookeeper" do
#  supports :restart => true, :start => true, :stop => true
#  action [ :restart ]
#end

