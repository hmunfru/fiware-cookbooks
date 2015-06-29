include_recipe "subversion"
include_recipe "maven"
include_recipe "cosmos::install_cdh3_repo"
include_recipe "cosmos::install_hadoop_commons"

remote_file "mahout" do
	source "http://ftp.cixug.es/apache/mahout/#{node['mahout']['version']}/mahout-distribution-#{node['mahout']['version']}-src.tar.gz"
	path "/opt/mahout-#{node['mahout']['version']}.tar.gz"
        action :create_if_missing
end

bash 'extract_module' do
  cwd ::File.dirname('/opt')
  code <<-EOH
    mkdir -p /opt/mahout-0.8
    tar xzf /opt/mahout-0.8.tar.gz -C /opt/mahout-0.8
    mv /opt/mahout-0.8/mahout-distribution-0.8/* /opt/mahout-0.8
    rm -rf /opt/mahout-0.8/mahout-distribution-0.8
    rm -rf /opt/mahout-0.8.tar.gz
    cd /opt/mahout-0.8
    mvn clean install -DskipTests
    EOH
end

