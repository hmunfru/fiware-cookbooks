# stop the datanode daemon
service "hadoop-0.20-datanode" do
        action [ :stop ]
end

# stop the tasktracker daemon
service "hadoop-0.20-tasktracker" do
        action [ :stop ]
end

