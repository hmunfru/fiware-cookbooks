package "apache2" do
  package_name node[:apache][:package]
  action :remove
end