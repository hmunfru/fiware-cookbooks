# File: cosmos/recipes/install_hadoop_commons.rb
# Cookbook: cosmos
# Recipe: install_hadoop_commons
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Install the Hadoop common software
#
# License...

# Stop previous runs of any Hadoop daemon
service "hadoop-0.20-jobtracker" do
        action [ :stop ]
end

service "hadoop-0.20-tasktracker" do
        action [ :stop ]
end

service "hadoop-0.20-datanode" do
        action [ :stop ]
end

service "hadoop-0.20-namenode" do
        action [ :stop ]
end

# Install the Hadoop core and native packages
package "hadoop-0.20"
package "hadoop-0.20-native"
