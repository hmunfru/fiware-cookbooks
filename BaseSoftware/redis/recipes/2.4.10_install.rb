if platform?("redhat", "centos", "fedora")
	include_recipe "yum::epel"
end

include_recipe "build-essential"

if platform?("redhat", "centos", "fedora")
	package "redis" do
		action :install
	end

        service "redis" do
                supports :status => true, :restart => true, :reload => true
                action :enable
        end

end

if platform?("debian", "ubuntu")
        package "redis-server" do
                action :install
        end
end

