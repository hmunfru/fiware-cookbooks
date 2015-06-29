name             'repository-ri'
maintainer       "CoNWeT"
maintainer_email "wirecloud@conwet.com"
license          "Apache 2.0"
description      'Installs/Configures repository-ri'
version          '3.2.1'

depends          "mongodb"
depends          "tomcat"

%w{ debian ubuntu centos redhat fedora }.each do |os|
    supports os
end
