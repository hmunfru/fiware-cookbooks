# File: cosmos/recipes/format_local_fs.rb
# Cookbook: cosmos
# Recipe: format_local_fs
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Format the Cosmos home directory in order to host the HDFS metadata
#
# License...

# Format command
execute "format_hdfs" do
        command "yes Y | hadoop namenode -format"
	user "hdfs"
end
