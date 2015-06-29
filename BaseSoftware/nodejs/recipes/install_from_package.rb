case node['platform_family']
  when 'rhel', 'fedora'
    file = '/usr/local/src/nodejs-stable-release.noarch.rpm'

    remote_file file do
      source 'http://vibol.hou.cc/files/x86_64/nodejs-0.6.15-1.x86_64.rpm'
      action :create_if_missing
    end

    yum_package 'nodejs-stable-release' do
      source file
      options '--nogpgcheck'
    end

    %w{ nodejs  }.each do |pkg|
      package pkg
    end
  when 'debian'
    apt_repository 'node.js' do
      uri 'http://ppa.launchpad.net/chris-lea/node.js/ubuntu'
      distribution node['lsb']['codename']
      components ['main']
      keyserver "keyserver.ubuntu.com"
      key "C7917B12"
      action :add
    end

    %w{ nodejs npm }.each do |pkg|
      package pkg
    end
  when 'smartos'
    %w{ nodejs }.each do |pkg|
      package pkg
    end
  else
    include_recipe "nodejs::install_from_source"
end
