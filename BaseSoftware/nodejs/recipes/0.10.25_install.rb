include_recipe "build-essential"

case node['platform_family']
  when 'rhel','fedora'
    package "openssl-devel"
  when 'debian'
    package "libssl-dev"
end

nodejs_tar = "node-v#{node['nodejs']['version3']}.tar.gz"
nodejs_tar_path = "v#{node['nodejs']['version3']}/#{nodejs_tar}"
#if node['nodejs']['version3'].split('.')[1].to_i >= 5
#  nodejs_tar_path = "v#{node['nodejs']['version3']}/#{nodejs_tar_path}"
#end
# Let the user override the source url in the attributes
nodejs_src_url = "#{node['nodejs']['src_url']}/#{nodejs_tar_path}"

remote_file "/usr/local/src/#{nodejs_tar}" do
  source nodejs_src_url
  checksum node['nodejs']['checksum']
  mode 0644
  action :create_if_missing
end

# --no-same-owner required overcome "Cannot change ownership" bug
# on NFS-mounted filesystem
execute "tar --no-same-owner -zxf #{nodejs_tar}" do
  cwd "/usr/local/src"
  creates "/usr/local/src/node-v#{node['nodejs']['version3']}"
end

make_threads = node['cpu'] ? node['cpu']['total'].to_i : 2
bash "compile node.js (on #{make_threads} cpu)" do
  # OSX doesn't have the attribute so arbitrarily default 2
  cwd "/usr/local/src/node-v#{node['nodejs']['version3']}"
  code <<-EOH
    PATH="/usr/local/bin:$PATH"
    ./configure --prefix=#{node['nodejs']['dir']} && \
    make -j #{make_threads}
  EOH
  creates "/usr/local/src/node-v#{node['nodejs']['version3']}/node"
end

execute "nodejs make install" do
  environment({"PATH" => "/usr/local/bin:/usr/bin:/bin:$PATH"})
  command "make install"
  cwd "/usr/local/src/node-v#{node['nodejs']['version3']}"
  not_if {File.exists?("#{node['nodejs']['dir']}/bin/node") && `#{node['nodejs']['dir']}/bin/node --version`.chomp == "v#{node['nodejs']['version3']}" }
end

file "/usr/local/src/node-v#{node['nodejs']['version3']}.tar.gz" do
	only_if {File.exists?("/usr/local/src/node-v#{node['nodejs']['version3']}.tar.gz")}
	action :delete
end
