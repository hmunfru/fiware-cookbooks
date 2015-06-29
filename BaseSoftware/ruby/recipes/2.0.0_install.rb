case node[:platform_family]
when "rhel", "fedora", "centos"

  packages = %w{
    curl
    gcc-c++ 
    patch 
    readline 
    readline-devel 
    zlib 
    zlib-devel
    libyaml-devel
    libffi-devel 
    openssl-devel 
    make 
    bzip2 
    autoconf 
    automake 
    libtool 
    bison
    glibc
  }
  
  packages.each do |pkg|
      package pkg do
  	action :install
      end
  end

  execute "curl -L get.rvm.io | bash -s stable" do
    action :run
  end

  bash "source_rvm" do
    code <<-EOH
    source /etc/profile.d/rvm.sh
    EOH
  end

  execute "rvm requirements" do
    action :run
  end

  execute "rvm install 2.0.0" do
    action :run
  end

  execute "rvm use 2.0.0 --default" do
    action :run
  end

  bash "current_ruby" do
    code <<-EOH
    source rvm rubygems current
    EOH
  end

  gemas = %w{
    rails
  }

  gemas.each do |gms|
      gem_package gms do
        action :install
      end
  end
end
