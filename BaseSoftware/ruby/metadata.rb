maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs Ruby and related packages"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.9.2"

attribute "languages/ruby/default_version",
 :display_name => "Default Ruby version",
 :recipes => [ "ruby", "symlinks" ],
 :choice => [ "1.8", "1.9", "1.9.1" ],
 :default => "1.8",
 :description => "The Ruby version to install with the ruby recipe and create symlinks for with the symlinks recipe. Unfortunately this setting only works fully on Ubuntu, Debian and Gentoo."

%w{ centos redhat fedora ubuntu debian arch gentoo oracle amazon scientific}.each do |os|
  supports os
end
