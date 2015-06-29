

execute "stop-SLSTopology" do
   cwd "/opt/storm"
   user "#{node['sls']['user']}"
   group "#{node['sls']['group']}"
   command "/opt/storm/bin/storm kill ServiceLevelSIEM"
end

