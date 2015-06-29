#
# Cookbook Name:: rpcdds
# Recipe:: default
#
# Copyright 2014, eProsima
#
# All rights reserved - Do Not Redistribute
#
remote_file "/root/eProsima_RPCDDS-0.3.2-CentOS6-RTIDDS-5.1.0.tar.gz" do
    source "http://www.eprosima.com/downloads/rpc-over-dds/0.3.2/eProsima_RPCDDS-0.3.2-CentOS6-RTIDDS-5.1.0.tar.gz"
end

script "untar_file" do
    interpreter "bash"
    user "root"
    cwd "/root"
    code <<-EOH
    tar -zxf eProsima_RPCDDS-0.3.2-CentOS6-RTIDDS-5.1.0.tar.gz
    EOH
end

package "fastcdr" do
    source "/root/fastcdr-0.2.2-1.el6.x86_64.rpm"
end

package "rpcdds" do
    source "/root/rpcdds-0.3.2-1.el6.x86_64.rpm"
end
