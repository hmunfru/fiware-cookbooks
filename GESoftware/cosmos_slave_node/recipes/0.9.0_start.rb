# start the datanode daemon
service "hadoop-0.20-datanode" do
        action [ :enable, :start ]
end

# start the tasktracker daemon 
service "hadoop-0.20-tasktracker" do
        action [ :enable, :start ]
end
