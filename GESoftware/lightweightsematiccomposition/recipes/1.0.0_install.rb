#
# Cookbook Name:: lightweightsematiccomposition
# Recipe:: 1.0.0_install.rb
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#



include_recipe "postgresqllight::client"
include_recipe "postgresqllight::server"
include_recipe "tomcatlight"

package "unzip" do
	action :install
end

execute "create-database-user" do
	code = <<-EOH
	sudo -u postgres psql -U postgres -c "select * from pg_user where usename='#{ node['activiti']['databaseuser']}'" | grep -c #{node['activiti']['databaseuser']}
	EOH
	command "sudo -u postgres createuser -U postgres -e -sw #{node['activiti']['databaseuser']}"
	not_if code
end


execute "setting-database-user-password" do
	command "sudo -u postgres psql -U postgres -c  \"ALTER USER #{node['activiti']['databaseuser']} WITH UNENCRYPTED PASSWORD '#{node['activiti']['databasepassword']}'\""
end


execute "create-database" do
	exists = <<-EOH
	sudo -u postgres psql -U postgres -c "select * from pg_database WHERE datname='#{node['activiti']['database']}'" | grep -c #{node['activiti']['database']}
	EOH
	command "sudo -u postgres createdb -U postgres -O #{node['activiti']['databaseuser']} -E utf8 #{node['activiti']['database']}"
	not_if exists
end


bash "create_folders" do
	code <<-EOL
	    mkdir -p #{node['lightwsemanticcomp']['files']['files']}
	    mkdir -p #{node['lightwsemanticcomp']['files']['war']}
	    mkdir -p #{node['lightwsemanticcomp']['files']['console']}
	EOL
end

remote_file  "compel" do
	source "#{node['lightwsemanticcomp']['urls']['urlcompel']}"
	path  "#{node['lightwsemanticcomp']['files']['files']}#{node['lightwsemanticcomp']['names']['namecompel']}"
end

bash "unzipfile_compel" do
	code <<-EOL
		unzip -o  #{node['lightwsemanticcomp']['files']['files']}#{node['lightwsemanticcomp']['names']['namecompel']} -d #{node['lightwsemanticcomp']['files']['war']}
	EOL
end

remote_file  "compeldependencies" do
	source "#{node['lightwsemanticcomp']['urls']['urlcompeldependencies']}"
	path  "#{node['lightwsemanticcomp']['files']['files']}#{node['lightwsemanticcomp']['names']['namecompeldependencies']}"
end

bash "unzipfile_compeldependencies" do
	code <<-EOL
		unzip -o  #{node['lightwsemanticcomp']['files']['files']}#{node['lightwsemanticcomp']['names']['namecompeldependencies']} -d #{node['lightwsemanticcomp']['files']['war']}
	EOL
end

directory "#{node['tomcat']['home']}/.aduna" do
  owner "#{node['tomcat']['user']}"
  group "#{node['tomcat']['group']}"
  mode 00755
  action :create
end

remote_file  "testservices" do
	source "#{node['lightwsemanticcomp']['urls']['urltestservices']}"
	path  "#{node['lightwsemanticcomp']['files']['files']}#{node['lightwsemanticcomp']['names']['nametestservices']}"
end

bash "unzipfile_testservices" do
	code <<-EOL
		unzip -o  #{node['lightwsemanticcomp']['files']['files']}#{node['lightwsemanticcomp']['names']['nametestservices']}  -d #{node['lightwsemanticcomp']['files']['war']}
	EOL
end

remote_file  "compeltools" do
	source "#{node['lightwsemanticcomp']['urls']['urltools']}"
	path  "#{node['lightwsemanticcomp']['files']['files']}#{node['lightwsemanticcomp']['names']['nametools']}"
end

bash "unzipfile_compeltools" do
	code <<-EOL
		unzip -o  #{node['lightwsemanticcomp']['files']['files']}#{node['lightwsemanticcomp']['names']['nametools']} -d #{node['lightwsemanticcomp']['files']['console']}
	EOL
end
	

execute "write_repositoryBean" do
	command "echo 'repositories.server.url = http://localhost/openrdf-sesame\nrepository.templateName = owlim-lite\nrepository.id = WebN1\nrepository.title = Web N+1\nrepository.ruleSet = owl-horst\nrepository.baseURL = http://www.atosresearch.eu/webn1\nrepository.entityIndexSize = 200000\nrepository.noPersitence = false\n\nrepository.numContext = 4\nrepository.context1.context = [http://dkm.fbk.eu/index.php/BPMN_Ontology>]\nrepository.context1.baseURI = http://dkm.fbk.eu/index.php/BPMN_Ontology\nrepository.context1.file = #{node['lightwsemanticcomp']['files']['consolescript']}/OntoBPMN.owl\n\nrepository.context2.context = [http://www.wsmo.org/ns/posm/0.2]\nrepository.context2.baseURI = http://www.wsmo.org/ns/posm/0.2\nrepository.context2.file = #{node['lightwsemanticcomp']['files']['consolescript']}/POSM.rdf.owl\n\nrepository.context3.context = [http://bridge-webn1.atosresearch.eu/bridge]\nrepository.context3.baseURI = http://bridge-webn1.atosresearch.eu/bridge\nrepository.context3.file = #{node['lightwsemanticcomp']['files']['consolescript']}/bridge.owl\n\nrepository.context4.context = [http://bridge-webn1.atosresearch.eu/bridge]\nrepository.context4.baseURI = http://bridge-webn1.atosresearch.eu/bridge\nrepository.context4.file = #{node['lightwsemanticcomp']['files']['consolescript']}/integra.owl\n' >> #{node['lightwsemanticcomp']['files']['consolescript']}/repositoryBean.properties"
	action :run
end

service "tomcat" do
	action :start
end


bash "install_war_into_tomcat" do
	code <<-EOL
	cp #{node['lightwsemanticcomp']['files']['war']}/*.war #{node["tomcat"]["webapp_dir"]}
	mkdir  #{node["tomcat"]["webapp_dir"]}/ROOT/ontologies
	cp -r  #{node['lightwsemanticcomp']['files']['war']}/ROOT/* #{node["tomcat"]["webapp_dir"]}/ROOT
	EOL
end

bash  "execute_sesame_console" do
	cwd  #{node['lightwsemanticcomp']['files']['consolescript']}
	command  "java -jar RepositoryCreatorForSesame.jar repositoryBean.properties"
	action :nothing
end

ruby_block "wait_until_sesame_has_starded" do
block do
		$filename = node["tomcat"]["webapp_dir"]
		$filename << "/openrdf-sesame"
		begin
			$exist = ::Dir.exist?($filename)
			puts("Direcroy #$filename does exist: #$exist")
			sleep 5
		end while !$exist
	  end
	  action :create
	  notifies :run, "bash[execute_sesame_console]"
end
