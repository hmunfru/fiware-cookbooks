# File: cosmos/recipes/install_java.rb
# Cookbook: cosmos
# Recipe: install_java
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Create the local directories for Hadoop (local OS-based folders where to store
#              HDFS metadata, temporal results, etc.
#
# License...

# IMPORTANT NOTES:
# 1. Cloudera Distribution for Hadoop only works with Oracle JDK 1.6, specifically 1.6.0_8 or
# higher, being recommended 1.6.0_26
# http://www.cloudera.com/content/cloudera-content/cloudera-docs/CDH3/CDH3u6/CDH3-Installation-Guide/cdh3ig_topic_24.html#topic_24
# This implies JDK 7 is not valid nor OpenJDK 6
# 2. Oracle JDK 1.6 is only available in the form of RPM packages or binaries. A license
# agreement must be accepted before dowloading it, thus it can not be directly dowloaded
# from the source. The RPM package is given under chef_home/cookbooks/cosmosv1/files/
# directory.
# 3. There is a workaround that, unfortunately, does not work anymore:
# wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/7/jdk-7-linux-x64.tar.gz"
# This could be implemented in Chef by means of http_request resource...
#
#http_request "get_oracle_jdk_1.6" do
# url "http://download.oracle.com/otn-pub/java/jdk/7/jdk-7-linux-x64.tar.gz"
# headers(
# {"Cookie" => "gpw_e24=http://www.oracle.com"}
# )
# action :get
# notifies :run, "bash[install_program]", :immediately
#end
#
#bash "install_program" do
# user "root"
# cwd "/tmp"
# code <<-EOH
# tar -zxf program-#{node[:program][:version]}.tar.gz
# (cd program-#{node[:program][:version]}/ && ./configure && make && make install)
# EOH
# action :nothing
#end

# Download the Java binaries as a RPM file
remote_file "#{Chef::Config[:file_cache_path]}/jdk-6u45-linux-amd64.rpm" do
	source "http://130.206.80.64/repo/rpm/x86_64/jdk-6u45-linux-amd64.rpm"
	mode 0700
end

# Install the RPM file
rpm_package "jdk-6u45-linux-amd64.rpm" do
	source "#{Chef::Config[:file_cache_path]}/jdk-6u45-linux-amd64.rpm"
	version "1.6.0_45"
end

# Export some environment variables
bash "export_java_home" do
	code <<-EOH
		export JAVA_HOME=/usr/java/jdk1.6.0_45/
		export PATH=$PATH:$JAVA_HOME/bin
		echo $JAVA_HOME
		echo $PATH
	EOH
end
