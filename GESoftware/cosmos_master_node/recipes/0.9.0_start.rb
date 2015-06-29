# start the namenode daemon
service "hadoop-0.20-namenode" do
        action [ :enable, :start ]
end

#include_recipe "cosmos::leave_safe_mode"
include_recipe "cosmos::create_hdfs_directories"

# start the jobtracker daemon
service "hadoop-0.20-jobtracker" do
        action [ :enable, :start ]
end

# start the httpfs server
execute "/usr/local/hadoop-hdfs-httpfs-0.20.2-cdh3u6/sbin/httpfs.sh start"
