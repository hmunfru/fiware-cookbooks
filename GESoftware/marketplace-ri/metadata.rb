name             'marketplace-ri'
maintainer       "CoNWeT"
maintainer_email "wirecloud@conwet.com"
license          "Apache 2.0"
description      'Installs/Configures marketplace-ri'
version          '3.2.1'

depends          "mysql",    "~>6.0"
depends          "database"
depends          "tomcat"           # From TID, not the official one

%w{ debian ubuntu centos redhat fedora }.each do |os|
    supports os
end
