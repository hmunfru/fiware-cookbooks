############################################
# Service Level SIEM Topology
############################################
default[:sls]["user"] = "root"
default[:sls]["group"] = "root"
default[:sls]["home"] = "/home/fiware"
default[:sls]["install_dir"] = "/home/fiware/install"

default[:sls][:topology][:workers] = "6"
default[:sls][:topology][:directiveSLS] = "70000"
default[:sls][:topology][:schemaParallelism] = "2"
default[:sls][:topology][:policyParallelism] = "2"
default[:sls][:topology][:dbWriterParallelism] = "2"
default[:sls][:topology][:actionParallelism] = "2"
default[:sls][:topology][:crossCorrParallelism] = "2"

default[:sls][:topology][:sslProtocol] = "TLS"
default[:sls][:topology][:keyStore] = "/etc/ossim/ssl/serverKeyStore.jks"
default[:sls][:topology][:keyStorePassword] = "fiware"
default[:sls][:topology][:keyStoreType] = "JKS"
default[:sls][:topology][:trustStore] = "/etc/ossim/ssl/serverTrustStore.jks"
default[:sls][:topology][:trustStorePassword] = "fiware"
default[:sls][:topology][:trustStoreType] = "JKS"

default[:java]["java_home"] = "/usr/local/jdk1.6.0_37"

############################################
# ZOOKEEPER ATTRIBUTES
###########################################
default[:zookeeper][:install_dir] = "/usr/local"
default[:zookeeper][:log_dir] = "/var/log/zookeeper"
default[:zookeeper][:port] = "2181"
default[:zookeeper][:version] = "3.4.5"

#############################################
# OSSIM ATTRIBUTES
#############################################
#
# server
#
default[:ossim][:server][:ip] = "127.0.0.1"
default[:ossim][:server][:port] = "50001"
default[:ossim][:server][:listen_port] = "40001"
default[:ossim][:server][:email_notify] = "system@sls.com"
default[:ossim][:server][:admin_ip] = "127.0.0.1"
default[:ossim][:server][:admin_netmask] = "255.255.255.0"
default[:ossim][:server][:admin_dns] = "130.206.1.19"
default[:ossim][:server][:admin_gateway] = "130.206.81.1"
default[:ossim][:server][:interface] = node[:network][:default_interface] 
default[:ossim][:server][:domain] = "alienvault"
default[:ossim][:server][:ntp_server] = "no"
default[:ossim][:server][:profile] = "Database, Server, Framework, Sensor"
default[:ossim][:server][:plugins] = "osiris, pam_unix, ssh, snare, sudo, fiware"

#
# database
#
default[:ossim][:server][:db_ip] = "127.0.0.1"
default[:ossim][:server][:db_port] = "3306"
default[:ossim][:server][:db_user] = "root"
default[:ossim][:server][:db_pass] = "#{node[:mysql][:server_root_password]}"

#
# Framework
#
default[:ossim][:control_framework] = "True"
default[:ossim][:frameworkd][:server_ip] = "127.0.0.1"
default[:ossim][:frameworkd][:server_port] = "40003"

#
# Sensor
#
default[:ossim][:sensor][:detectors] = "snare, syslog, fiware"
default[:ossim][:sensor][:monitors] = "nmap-monitor, ntop-monitor, ossim-monitor, ping-monitor, whois-monitor,wmi-monitor"
default[:ossim][:sensor][:ids_rules_flow_control] = "yes"

#
# SSL Access
#
default[:ossim][:ssl][:enable] = "True"
default[:ossim][:ssl][:socat] = "yes"
default[:ossim][:ssl][:cert] = "/etc/ossim/ssl/server.pem"
default[:ossim][:ssl][:port] = "50001"

#
# Storm SLS Topology
#
default[:ossim][:storm][:enable] = "True"
default[:ossim][:storm][:ip] = "127.0.0.1"
default[:ossim][:storm][:port] = "41000"
default[:ossim][:storm][:send_events] = "True"
default[:ossim][:storm][:enable_ssl] = "True"


#
# Daemon
#
default[:ossim][:daemon][:enable] = "True"
default[:ossim][:daemon][:pid] = "/var/run/ossim-agent.pid"


#
# log
#
default[:ossim][:log][:path] = "/var/log/ossim"
default[:ossim][:log][:file] = "#{node[:ossim][:log][:path]}/agent.log"
default[:ossim][:log][:error] = "#{node[:ossim][:log][:path]}/agent_error.log"
default[:ossim][:log][:stats] = "#{node[:ossim][:log][:path]}/agent_stats.log"



#
# default values for plugins
#
default[:ossim][:plugin_defaults][:sensor] = node[:ipaddress]
default[:ossim][:plugin_defaults][:interface] = node[:network][:default_interface]
#
# FIXME: This is the connect string to ossim database, it has to change when we deploy
# a full ossim infraestructure
default[:ossim][:plugin_defaults][:dsn] = "mysql:127.0.0.1:alienvault:root:H7aQc92Ehk"
default[:ossim][:plugin_defaults][:tzone] = "Europe/Madrid"

#
# Plugins
#
# detectors
#
default[:ossim][:plugins]["fiware"] = { :enable => true, :path => "/etc/ossim/agent/plugins/fiware.cfg" }
default[:ossim][:plugins]["apache"] = { :enable => false, :path => "/etc/ossim/agent/plugins/apache.cfg" }
default[:ossim][:plugins]["arpwatch"] = { :enable => false, :path => "/etc/ossim/agent/plugins/arpwatch.cfg" }
default[:ossim][:plugins]["cisco-ids"] = { :enable => false, :path => "/etc/ossim/agent/plugins/cisco-ids.cfg" }
default[:ossim][:plugins]["cisco-pix"] = { :enable => false, :path => "/etc/ossim/agent/plugins/cisco-pix.cfg" }
default[:ossim][:plugins]["cisco-router"] = { :enable => false, :path => "/etc/ossim/agent/plugins/cisco-router.cfg" }
default[:ossim][:plugins]["cisco-vpn"] = { :enable => false, :path => "/etc/ossim/agent/plugins/cisco-vpn.cfg" }
default[:ossim][:plugins]["cisco-ips"] = { :enable => false, :path => "/etc/ossim/agent/plugins/cisco-ips.cfg" }
default[:ossim][:plugins]["clamav"] = { :enable => false, :path => "/etc/ossim/agent/plugins/clamav.cfg" }
default[:ossim][:plugins]["clurgmgr"] = { :enable => false, :path => "/etc/ossim/agent/plugins/clurgmgr.cfg" }
default[:ossim][:plugins]["fw1ngr60"] = { :enable => false, :path => "/etc/ossim/agent/plugins/fw1ngr60.cfg" }
default[:ossim][:plugins]["gfi"] = { :enable => false, :path => "/etc/ossim/agent/plugins/gfi.cfg" }
default[:ossim][:plugins]["heartbeat"] = { :enable => false, :path => "/etc/ossim/agent/plugins/heartbeat.cfg" }
default[:ossim][:plugins]["iis"] = { :enable => false, :path => "/etc/ossim/agent/plugins/iis.cfg" }
default[:ossim][:plugins]["intrushield"] = { :enable => false, :path => "/etc/ossim/agent/plugins/intrushield.cfg" }
default[:ossim][:plugins]["iphone"] = { :enable => false, :path => "/etc/ossim/agent/plugins/iphone.cfg" }
default[:ossim][:plugins]["iptables"] = { :enable => false, :path => "/etc/ossim/agent/plugins/iptables.cfg" }
default[:ossim][:plugins]["kismet"] = { :enable => false, :path => "/etc/ossim/agent/plugins/kismet.cfg" }
default[:ossim][:plugins]["mwcollect"] = { :enable => false, :path => "/etc/ossim/agent/plugins/mwcollect.cfg" }
default[:ossim][:plugins]["nagios"] = { :enable => false, :path => "/etc/ossim/agent/plugins/nagios.cfg" }
default[:ossim][:plugins]["netgear"] = { :enable => false, :path => "/etc/ossim/agent/plugins/netgear.cfg" }
default[:ossim][:plugins]["netscreen-manager"] = { :enable => false, :path => "/etc/ossim/agent/plugins/netscreen-manager.cfg" }
default[:ossim][:plugins]["netscreen-nsm"] = { :enable => false, :path => "/etc/ossim/agent/plugins/netscreen-nsm.cfg" }
default[:ossim][:plugins]["netscreen-firewall"] = { :enable => false, :path => "/etc/ossim/agent/plugins/netscreen-firewall.cfg" }
default[:ossim][:plugins]["ntsyslog"] = { :enable => false, :path => "/etc/ossim/agent/plugins/ntsyslog.cfg" }
default[:ossim][:plugins]["osiris"] = { :enable => false, :path => "/etc/ossim/agent/plugins/osiris.cfg" }
default[:ossim][:plugins]["ossec"] = { :enable => false, :path => "/etc/ossim/agent/plugins/ossec.cfg" }
default[:ossim][:plugins]["ossim-agent"] = { :enable => false, :path => "/etc/ossim/agent/plugins/ossim-agent.cfg" }
default[:ossim][:plugins]["p0f"] = { :enable => false, :path => "/etc/ossim/agent/plugins/p0f.cfg" }
default[:ossim][:plugins]["pads"] = { :enable => false, :path => "/etc/ossim/agent/plugins/pads.cfg" }
default[:ossim][:plugins]["pam_unix"] = { :enable => false, :path => "/etc/ossim/agent/plugins/pam_unix.cfg" }
default[:ossim][:plugins]["postfix"] = { :enable => false, :path => "/etc/ossim/agent/plugins/postfix.cfg" }
default[:ossim][:plugins]["radiator"] = { :enable => false, :path => "/etc/ossim/agent/plugins/radiator.cfg" }
default[:ossim][:plugins]["realsecure"] = { :enable => false, :path => "/etc/ossim/agent/plugins/realsecure.cfg" }
default[:ossim][:plugins]["rrd"] = { :enable => false, :path => "/etc/ossim/agent/plugins/rrd.cfg" }
default[:ossim][:plugins]["snortunified"] = { :enable => false, :path => "/etc/ossim/agent/plugins/snortunified.cfg" }
default[:ossim][:plugins]["spamassassin"] = { :enable => false, :path => "/etc/ossim/agent/plugins/spamassassin.cfg" }
default[:ossim][:plugins]["squid"] = { :enable => false, :path => "/etc/ossim/agent/plugins/squid.cfg" }
default[:ossim][:plugins]["symantec-ams"] = { :enable => false, :path => "/etc/ossim/agent/plugins/symantec-ams.cfg" }
default[:ossim][:plugins]["ssh"] = { :enable => false, :path => "/etc/ossim/agent/plugins/ssh.cfg" }
default[:ossim][:plugins]["stonegate"] = { :enable => false, :path => "/etc/ossim/agent/plugins/stonegate.cfg" }
default[:ossim][:plugins]["sudo"] = { :enable => false, :path => "/etc/ossim/agent/plugins/sudo.cfg" }
default[:ossim][:plugins]["syslog"] = { :enable => false, :path => "/etc/ossim/agent/plugins/syslog.cfg" }
default[:ossim][:plugins]["snare"] = { :enable => true, :path => "/etc/ossim/agent/plugins/snare.cfg" }
default[:ossim][:plugins]["tarantella"] = { :enable => false, :path => "/etc/ossim/agent/plugins/tarantella.cfg" }
default[:ossim][:plugins]["fidelis"] = { :enable => false, :path => "/etc/ossim/agent/plugins/fidelis.cfg" }
default[:ossim][:plugins]["rsa-secureid"] = { :enable => false, :path => "/etc/ossim/agent/plugins/rsa-secureid.cfg" }
default[:ossim][:plugins]["cisco-acs"] = { :enable => false, :path => "/etc/ossim/agent/plugins/cisco-acs.cfg" }
default[:ossim][:plugins]["fortiguard"] = { :enable => false, :path => "/etc/ossim/agent/plugins/fortiguard.cfg" }

# monitors
#
default[:ossim][:plugins]["wmi-monitor"] = { :enable => true, :path => "/etc/ossim/agent/plugins/wmi-monitor.cfg" }
default[:ossim][:plugins]["nmap"] = { :enable => true, :path => "/etc/ossim/agent/plugins/nmap-monitor.cfg" }
default[:ossim][:plugins]["ntop"] = { :enable => true, :path => "/etc/ossim/agent/plugins/session-monitor.cfg" }
default[:ossim][:plugins]["opennms"] = { :enable => false, :path => "/etc/ossim/agent/plugins/opennms-monitor.cfg" }
default[:ossim][:plugins]["ossim-ca"] = { :enable => true, :path => "/etc/ossim/agent/plugins/ossim-monitor.cfg" }
default[:ossim][:plugins]["ping"] = { :enable => true, :path => "/etc/ossim/agent/plugins/ping-monitor.cfg" }
default[:ossim][:plugins]["tcptrack"] = { :enable => false, :path => "/etc/ossim/agent/plugins/tcptrack-monitor.cfg" }
default[:ossim][:plugins]["nessus"] = { :enable => false, :path => "/etc/ossim/agent/plugins/nessus-monitor.cfg" }
default[:ossim][:plugins]["whois"] = { :enable => true, :path => "/etc/ossim/agent/plugins/whois-monitor.cfg" }
default[:ossim][:plugins]["malwaredomainlist"] = { :enable => false, :path => "/etc/ossim/agent/plugins/malwaredomainlist.cfg" }

#
# STORM ATTRIBUTES
#

default['storm']['version'] = "0.9.0-wip16"
#TODO: install_dir = "/opt/storm"
default['storm']['install_dir'] = "/home/fiware"
default['storm']['log_dir'] = "/var/log/storm"
default['storm']['cluster_role'] = "ServiceLevelSIEM"
default['storm']['component'] = "standalone"
#TODO: user=storm; group=storm; home=/home/fi-test

# general storm attributes
default['storm']['storm_nimbus'] = "127.0.0.1" 
default['storm']['java_lib_path'] = "/usr/local/lib:/opt/local/lib:/usr/lib"
default['storm']['local_dir'] = "/mnt/storm"
default['storm']['local_mode_zmq'] = "false"
default['storm']['cluster_mode'] = "distributed"

# zookeeper attributes
default['storm']['zookeeper']['servers'] = Array.new
#default['storm']['zookeeper']['servers'] = ["127.0.0.1", "127.0.0.2"] 
default['storm']['zookeeper']['servers'] = ["127.0.0.1"]
default['storm']['zookeeper']['port'] = 2181
default['storm']['zookeeper']['root'] = "/storm"
default['storm']['zookeeper']['session_timeout'] = 20000
default['storm']['zookeeper']['retry_times'] = 5
default['storm']['zookeeper']['retry_interval'] = 1000

# supervisor attributes
default['storm']['supervisor']['workers'] = 6
default['storm']['supervisor']['childopts'] = "-Xmx1024m"
default['storm']['supervisor']['worker_start_timeout'] = 120
default['storm']['supervisor']['worker_timeout_secs'] = 30
default['storm']['supervisor']['monitor_frequecy_secs'] = 3
default['storm']['supervisor']['heartbeat_frequency_secs'] = 5
default['storm']['supervisor']['enable'] = true
default[:storm][:supervisor][:env] = Hash.new
default[:storm][:supervisor][:ports] = [6700, 6701, 6702, 6703, 6704, 6705]

# worker attributes
default['storm']['worker']['childopts'] = "-Xmx1280m -XX:+UseConcMarkSweepGC -Dcom.sun.management.jmxremote"
default['storm']['worker']['heartbeat_frequency_secs'] = 1
default['storm']['task']['heartbeat_frequency_secs'] = 3
default['storm']['task']['refresh_poll_secs'] = 10
default['storm']['zmq']['threads'] = 1
default['storm']['zmq']['longer_millis'] = 5000

# nimbus attributes
default['storm']['nimbus']['host'] = ""
default['storm']['nimbus']['thrift_port'] = 6627
default['storm']['nimbus']['childopts'] = "-Xmx1024m"
default['storm']['nimbus']['task_timeout_secs'] = 30
default['storm']['nimbus']['supervisor_timeout_secs'] = 60
default['storm']['nimbus']['monitor_freq_secs'] = 10
default['storm']['nimbus']['cleanup_inbox_freq_secs'] = 600
default['storm']['nimbus']['inbox_jar_expiration_secs'] = 3600
default['storm']['nimbus']['task_launch_secs'] = 120
default['storm']['nimbus']['reassign'] = true
default['storm']['nimbus']['file_copy_expiration_secs'] = 600

# ui attributes
default['storm']['ui']['port'] = 8080
default['storm']['ui']['childopts'] = "-Xmx768m"

# drpc attributes
default['storm']['drpc']['port'] = 3772
default['storm']['drpc']['invocations_port'] = 3773
default['storm']['drpc']['request_timeout_secs'] = 600

# transactional attributes
default['storm']['transactional']['zookeeper']['root'] = "/storm-transactional"
default['storm']['transactional']['zookeeper']['port'] = 2181

# topology attributes
default['storm']['topology']['debug'] = false
default['storm']['topology']['optimize'] = true
default['storm']['topology']['workers'] = 1
default['storm']['topology']['acker_executors'] = 1
default['storm']['topology']['acker_tasks'] = "null"
default['storm']['topology']['tasks'] = "null"
default['storm']['topology']['message_timeout_secs'] = 30
default['storm']['topology']['skip_missing_kryo_registrations'] = false
default['storm']['topology']['max_task_parallelism'] = "null"
default['storm']['topology']['max_spout_pending'] = "null"
default['storm']['topology']['state_synchronization_timeout_secs'] = 60
default['storm']['topology']['stats_sample_rate'] = 0.05
default['storm']['topology']['fall_back_on_java_serialization'] = true
default['storm']['topology']['worker_childopts'] = "null"

# Service states
default[:storm][:nimbus ][:run_state] = :start
default[:storm][:nimbus ][:dashboard][:run_state] = :start
default[:storm][:supervisor][:run_state] = :start





