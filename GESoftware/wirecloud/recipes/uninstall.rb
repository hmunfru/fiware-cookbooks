#
# Cookbook Name:: wirecloud
# Recipe:: uninstall
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

# Stop

apache_site "wirecloud.conf" do
    enable false
end

service "apache2" do
    action :reload
end

# Uninstall

user "wirecloud" do
    action :remove
end

python_pip "wirecloud" do
    action :remove
end
