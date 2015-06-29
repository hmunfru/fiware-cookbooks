###################################################################################
### File Name    : 1.0.0_install.rb		               			###
### Description  : Recipe to Install flod enabler on ubuntu OS. 		###
### Version      : 1.0.0					        	###
### Author       : Orange Labs P&S - India, Pallav Gupta & Antriksh Mathur 	###
### Creation On  : 15-05-2014					        	###
### Modified On  : None 						        ###	
### Modification : None							        ###
###################################################################################


## Checking OS compatibility for flod enabler
if node['platform'] != "ubuntu"
	log "*** Sorry, but the flod enabler requires a ubuntu OS ***"
end

return if node['platform'] != "ubuntu"

## Stopping if flod enabler is already installed and running
include_recipe "flod-enabler::1.0.0_stop"

## Updating apt-get repo
execute "apt-get update" do  
	action :run
end

## Installing dependency package: dpkg-dev
package "dpkg-dev" do
	action :install
end

## Installing dependency package: autoconf
package "autoconf" do
	action :install
end

## Installing dependency package: automake
package "automake" do
	action :install
end

## Installing dependency package: flex
package "flex" do
	action :install
end

## Installing dependency package: bison
package "bison" do
	action :install
end

## Installing dependency package: gperf
package "gperf" do
	action :install
end

## Installing dependency package: gawk
package "gawk" do
	action :install
end

## Installing dependency package: m4
package "m4" do
	action :install
end
 
## Installing dependency package: make
package "make" do
	action :install
end

## Installing dependency package: openssl
package "openssl" do
	action :install
end

## Installing dependency package: libssl-dev
package "libssl-dev" do
	action :install
end

## Installing dependency package: unzip
package "unzip" do
	action :install
end

## Installing ant
package "ant" do
        action :install
end


## Downloading Flod enabler packages : virtuoso-opensource-6.1.4.tar, PSFrontEnd.zip, SemanticWrapper.zip.

bash "Downloading packages..." do
  user "root"
  cwd "/root"
  code <<-EOH
  wget --user #{node['flod-enabler']['repo_user']} --password #{node['flod-enabler']['repo_password']} "#{node['flod-enabler']['repo_path']}PSFrontEnd.zip"
  wget --user #{node['flod-enabler']['repo_user']} --password #{node['flod-enabler']['repo_password']} "#{node['flod-enabler']['repo_path']}SemanticWrapper.zip"
  mkdir Virtuoso
  cd Virtuoso
  wget --user #{node['flod-enabler']['repo_user']} --password #{node['flod-enabler']['repo_password']} "#{node['flod-enabler']['repo_path']}virtuoso-opensource-6.1.4.tar"
  EOH
end




## Extracting vituoso package
bash "Extracting virtuoso..." do
  user "root"
  cwd "/root/Virtuoso"
  code <<-EOH
  tar -xvf virtuoso-opensource-6.1.4.tar
  EOH
end

## Configuring virtuoso
bash "Configuring virtuoso" do
  user "root"
  cwd "/root/Virtuoso"
  code <<-EOH
  cd virtuoso-opensource-6.1.4
  ./configure --prefix=/root/Virtuoso
  EOH
end

## Making virtuoso
bash "Making virtuoso" do
  user "root"
  cwd "/root/Virtuoso/virtuoso-opensource-6.1.4"
  code <<-EOH
  nice -n -19 make
  EOH
end

## Installing virtuoso
bash "Installing virtuoso" do
  user "root"
  cwd "/root/Virtuoso/virtuoso-opensource-6.1.4"
  code <<-EOH
  make install
 EOH
end

## Deleting old service
file "/etc/init.d/virtuoso" do
  owner "root"
  group "root"
  action :delete
end

## Creating virtuoso config file
template "/etc/init.d/virtuoso" do
  source   "virtuoso.erb"
  owner    "root"
  group    "root"
  mode     "777"
end

## Installing SemanticWrapper
bash "Installing SemanticWrapper" do
  user "root"
  cwd "/root"
  code <<-EOH
  unzip -o SemanticWrapper.zip
 EOH
not_if "test -d /root/SemanticWrapper.zip"
end

## Deleting old file
file "/root/SemanticWrapper/conf/config.properties" do
  owner "root"
  group "root"
  action :delete
end

## Creating SemanticWrapper config file
template "/root/SemanticWrapper/conf/config.properties" do
  source   "config.properties.erb"
  owner    "root"
  group    "root"
  mode     "0644"
end

## Installing PSFrontEnd
bash "Installing PSFrontEnd" do
  user "root"
  cwd "/root"
  code <<-EOH
  unzip -o PSFrontEnd.zip
 EOH
not_if "test -d /root/PSFrontEnd.zip"
end

## Removing unnecessary zip files
bash "Removing unnecessary zip files" do
  user "root"
  cwd "/root"
  code <<-EOH
  rm -rf SemanticWrapper.zip.*
  rm -rf PSFrontEnd.zip.*
 EOH
end
