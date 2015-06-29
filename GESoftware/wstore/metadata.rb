name             "wstore"
maintainer       "CoNWeT"
maintainer_email "wstore@conwet.com"
license          "EUPL v1.1+"
description      "Installs and configures WStore"
version          "0.3.0"

depends          "build-essential"
depends          "python"
depends          "mongodb"
depends          "apache2"
depends          "yum"

%w{ debian ubuntu centos redhat fedora }.each do |os|
    supports os
end
