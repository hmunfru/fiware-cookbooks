#
# Cookbook Name:: poi_dp
# Recipe:: install
#
# Copyright 2014, CIE, University of Oulu
#
# All rights reserved - Do Not Redistribute
#

#This chef recipe supports only Ubuntu version 12.04
if platform?("ubuntu") and node[:platform_version] == "12.04"
	log "Ubuntu 12.04 detected, installing POI data provider..."
	
	execute "apt-get update" do  
		action :run
	end
	
	package "postgresql-9.1" do
		action :install
	end 

	package "postgresql-contrib" do
	  action :install
	end

	package "postgis" do
	  action :install
	end

	package "postgresql-9.1-postgis" do
	  action :install
	end

	package "mongodb" do
	  action :install
	end

	package "apache2" do
	  action :install
	end

	package "php5" do
	  action :install
	end

	package "php5-pgsql" do
	  action :install
	end

	package "php-pear" do
		action :install
	end

	package "php5-dev" do
		action :install
	end

	package "gcc" do
		action :install
	end

	package "make" do
		action :install
	end
	
	package "unzip" do
		action :install
	end

	remote_file "/tmp/poi_dp_0_3_3_3.zip" do
		source "http://forge.fi-ware.org/frs/download.php/1202/poi_dp_0_3_3_3.zip"
	end

	bash "install_and_configure_software" do
		user "root"
		cwd "/tmp"
		code <<-EOT
			export HOME=/root
			pecl install mongo
			touch /etc/php5/conf.d/mongo.ini
			echo "extension=mongo.so" >> /etc/php5/conf.d/mongo.ini
			/etc/init.d/apache2 restart
			sudo -u postgres createuser -d -R -S gisuser
			sudo -u postgres createdb --encoding=UTF8 --owner=gisuser --template=template0 poidatabase
			sudo -u postgres psql -d poidatabase -f /usr/share/postgresql/9.1/contrib/postgis-1.5/postgis.sql
			sudo -u postgres psql -d poidatabase -f /usr/share/postgresql/9.1/contrib/postgis-1.5/spatial_ref_sys.sql
			sudo -u postgres psql -d poidatabase -f /usr/share/postgresql/9.1/contrib/postgis_comments.sql
			sudo -u postgres psql -d poidatabase -c "GRANT SELECT ON spatial_ref_sys TO PUBLIC;"
			sudo -u postgres psql -d poidatabase -c "GRANT ALL ON geometry_columns TO gisuser;"
			sudo -u postgres psql -d poidatabase -c 'create extension "uuid-ossp";'
			cp --backup=numbered /etc/postgresql/9.1/main/pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf.backup_by_poi_dp
			sed -i 's/local   all             all                                     peer/local   all             all                                     trust/g' /etc/postgresql/9.1/main/pg_hba.conf
			/etc/init.d/postgresql restart
			unzip poi_dp_0_3_3_3.zip
			cd poi_dp/install_scripts
			./create_tables.sh
			cd /tmp
			cp -r poi_dp/php /var/www/poi_dp
			wget http://getcomposer.org/composer.phar
			php composer.phar require justinrainbow/json-schema:~1.3
			cp -r vendor /var/www/poi_dp
			
		EOT
	end

else 
	Chef::Application.fatal!("This chef recipe for installing the POI data provider supports only Ubuntu 12.04!")
end
