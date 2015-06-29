#
# Cookbook Name:: semanticas
# Recipe:: default
#
# Copyright 2013, ATOS
#
# All rights reserved - Do Not Redistribute
#

jboss_parent="/usr/local/jboss"
jboss_home="/usr/local/jboss/default"



bash "put_files" do
  code <<-EOH
  cd /tmp
  wget http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz
  tar xvzf jboss-as-7.1.1.Final.tar.gz -C #{jboss_parent}
  chown -R jboss:jboss #{jboss_parent}
  ln -s #{jboss_parent}/jboss-as-7.1.1.Final #{jboss_home}
  rm -f #{tarball_name}.tar.gz
  EOH
  not_if "test -d #{jboss_home}"
end