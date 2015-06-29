unless node['pkg_name'] == nil
  if node['platform'] == "ubuntu"
    execute "apt-get update" do 
      command "apt-get update"
    end
  end
  
  package node['pkg_name'] do
    action :install 
  end
end

remote_file "/opt/#{node['file_name']}" do
  source node['kiara_skd_path']
  mode 0700
end

execute "untar-kiara-sdk" do
  cwd "/opt"
  user "root"
  group "root"
  command "tar xjvf #{node['file_name']}"
end


#cookbook_file "/opt/kiara-sdk-0.13.0-centos-6.2-x86_64-Release-2014-07-15.tar.bz2" do
#  source "kiara-sdk-0.13.0-centos-6.2-x86_64-Release-2014-07-15.tar.bz2"
#  mode 0755
#  action :create
#end