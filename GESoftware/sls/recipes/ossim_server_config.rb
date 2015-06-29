# SLS cookbook
# recipe: ossim_server_config 
#
# This recipe is used to config ossim-server
#

template "/etc/ossim/ossim_setup.conf" do
    source "ossim_setup.conf.erb"
    mode 0644
    owner "root"
    group "root"
end

template "/etc/ossim/framework/ossim.conf" do
    source "ossim-framework.conf.erb"
    mode 0644
    owner "root"
    group "root"
end

template "/etc/ossim/idm/config.xml" do
    source "config-idm.xml.erb"
    mode 0644
    owner "root"
    group "root"
end

template "/etc/ossim/server/config.xml" do
    source "config-ossimserver.xml.erb"
    mode 0644
    owner "root"
    group "root"
end


