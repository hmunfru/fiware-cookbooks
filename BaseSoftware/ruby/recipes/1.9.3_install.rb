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

  execute "rvm install 1.9.3" do
    action :run
  end

  execute "rvm use 1.9.3 --default" do
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

when "debian"
  ruby_packages "1.9"

  package "rubygems" do
    action :install
  end

  gem_package "rails" do
    action :install
  end

end
