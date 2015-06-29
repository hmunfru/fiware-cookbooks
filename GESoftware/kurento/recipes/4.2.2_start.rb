# Cookbook Name:: 4.2.2_start
# Recipe:: default
#
# Author:: Santiago Gala (<sgala@apache.org>)
#          Pedro Garcia (<pgarcia@gsyc.es)
# Copyright 2013, Fun-Lab URJC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Start service Kurento

service "kurento" do
  supports :start => true, :stop => true, :status => true,:restart => true, :reload => true 
  action [ :enable, :start ]
end 

# Start service JBoss

service "jboss" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [ :enable, :start ]
end
