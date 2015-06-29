# File: cosmos/recipes/leave_safe_mode.rb
# Cookbook: cosmos
# Recipe: leave_safe_mode
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: HDFS may be put on safe mode under certain cicumstances. One of them is when the total amount of
#              disk is very low. By using this code the safe mode is left.
#
# License...

# Force to leave the safemode. Should not be necessary, but without this the HDFS does not work if
# the disk space os too low
execute "leave_safe_mode" do
        command "hadoop dfsadmin -safemode leave"
	user "hdfs"
end

