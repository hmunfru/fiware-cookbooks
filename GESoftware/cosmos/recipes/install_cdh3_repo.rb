# File: cosmos/recipes/install_cdh3_repo.rb
# Cookbook: cosmos
# Recipe: install_cdh3_repo
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Install the Cloudera repositories for Hadoop
#
# License...

# Install cloudera-cdh3.repo if not yet existing
template "/etc/yum.repos.d/cloudera-cdh3.repo" do
        source "repos/cloudera-cdh3.repo.erb"
        not_if "ls /etc/yum.repos.d/ | grep cloudera-cdh3.repo"
end

# Import Cloudera public GPG key to the repository
execute "add_cloudera_public_gpg_key" do
        command "rpm --import http://archive.cloudera.com/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera"
end
