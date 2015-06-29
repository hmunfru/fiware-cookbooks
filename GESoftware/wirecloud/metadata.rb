name             "wirecloud"
maintainer       "CoNWeT"
maintainer_email "wirecloud@conwet.com"
license          "Apache 2.0"
description      "Installs and configures Wirecloud"
version          "0.6.4"

depends          "build-essential"
depends          "python"
depends          "apache2"

%w{ debian ubuntu centos redhat fedora }.each do |os|
    supports os
end
