
execute "run-SLSTopology" do
   cwd "/opt/storm"
   user "#{node['sls']['user']}"
   group "#{node['sls']['group']}" 
#   environment ('STORM_HOME' => '/opt/storm',
#          'JAVA_HOME' => '/usr/local/jdk1.6.0_37')
   command "export STORM_HOME=/opt/storm; export JAVA_HOME=/usr/local/jdk1.6.0_37;cd /opt/storm; sleep 20; /opt/storm/bin/storm jar /opt/storm/topologies/ServiceLevelSIEM-3.3.3-SNAPSHOT-jar-with-dependencies.jar storm.sls.main.SLSTopologyPattern ServiceLevelSIEM"
   only_if "test -f /opt/storm/logs/supervisor.log"
end

