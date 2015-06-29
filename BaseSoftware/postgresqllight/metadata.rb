name              "postgresqllight"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs and configures postgresql for clients or servers"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "3.4.0"
recipe            "postgresqllight", "Includes postgresqllight::client"
recipe            "postgresqllight::ruby", "Installs pg gem for Ruby bindings"
recipe            "postgresqllight::client", "Installs postgresql client package(s)"
recipe            "postgresqllight::server", "Installs postgresql server packages, templates"
recipe            "postgresqllight::server_redhat", "Installs postgresql server packages, redhat family style"
recipe            "postgresqllight::server_debian", "Installs postgresql server packages, debian family style"

%w{ubuntu debian fedora suse amazon}.each do |os|
  supports os
end

%w{redhat centos scientific oracle}.each do |el|
  supports el, ">= 6.0"
end

depends "apt", ">= 1.9.0"
depends "build-essential"
depends "openssl"
