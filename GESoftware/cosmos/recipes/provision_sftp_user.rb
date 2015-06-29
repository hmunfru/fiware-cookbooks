# File: cosmos/recipes/provision_sftp_user.rb
# Cookbook: cosmos
# Recipe: provision_sftp_user
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Install a MySQL server and configure it in order to store SFTP users and their
#              credentials.
#
# License...

# MySQL configuration
service "mysqld" do
        action :restart
end

# Create a .sql file for the user provision
template "/tmp/sftp_provision.sql" do
        source "sftp-conf/provision.sql.erb"
        variables(
                :mysql_password => node[:mysql][:password]
        )
end

# Execute the .sql file
execute "mysql < /tmp/sftp_provision.sql"

#Delte the .sql file
file "/tmp/sftp_provision.sql" do
        action :delete
end
