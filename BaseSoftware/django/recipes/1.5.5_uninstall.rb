python_pip "django" do
	action :remove
end

yum_package "mysql-devel.x86_64" do
	action :remove
end
