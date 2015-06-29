file "/opt/#{node['file_name']}" do
  action :delete
end

directory "/opt/kiara_sdk/" do
  action :delete
  recursive true
end

unless node['pkg_name'] == nil
  package node['pkg_name'] do
    action :remove 
  end
end