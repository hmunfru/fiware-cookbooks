# stop the namenode daemon
service "hadoop-0.20-namenode" do
        action [ :stop ]
end

# stop the jobtracker daemon
service "hadoop-0.20-jobtracker" do
        action [ :stop ]
end

# stop the httpfs server
execute "/usr/local/hadoop-hdfs-httpfs-0.20.2-cdh3u6/sbin/httpfs.sh stop"
