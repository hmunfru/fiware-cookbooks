execute "nodejs make uninstall" do
	environment({"PATH" => "/usr/local/bin:/usr/bin:/bin:$PATH"})
	command "make uninstall"
	cwd "/usr/local/src/node-v#{node['nodejs']['version3']}"
end

directory "/usr/local/src/node-v#{node['nodejs']['version3']}" do
	recursive true
	only_if {File.exists?("/usr/local/src/node-v#{node['nodejs']['version3']}")}
	action :delete
end
