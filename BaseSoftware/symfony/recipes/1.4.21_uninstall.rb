directory "/home/sfprojects/#{node['symfony']['proyect']}" do
	recursive true
	only_if {File.exists?("/home/sfprojects/#{node['symfony']['proyect']}")}
	action :delete
end
