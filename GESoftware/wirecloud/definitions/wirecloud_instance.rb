#
# Cookbook Name:: wirecloud
# Definition:: wirecloud_instance
#
# Copyright (c) 2013-2014 CoNWeT Lab., Universidad Politécnica de Madrid
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

define :wirecloud_instance, :user => nil, :group => nil, :configure => false do

    if params[:configure]

        execute "wirecloud-admin startproject #{params[:name]}" do
          cwd node[:wirecloud][:install_dir]
          user params[:user]
          group params[:group]
          command ". #{node[:wirecloud][:virtualenv]}/bin/activate; #{node[:wirecloud][:virtualenv]}/bin/wirecloud-admin startproject --quick-start #{params[:name]}"
          not_if do FileTest.directory?(node[:wirecloud][:install_dir] + params[:name]) end
        end

    else
 
        execute "wirecloud-admin startproject #{params[:name]}" do
          cwd node[:wirecloud][:install_dir]
          user params[:user]
          group params[:group]
          command "#{node[:wirecloud][:virtualenv]}/bin/wirecloud-admin startproject #{params[:name]}"
          not_if do FileTest.directory?(node[:wirecloud][:install_dir] + params[:name]) end
        end

    end
        
end
