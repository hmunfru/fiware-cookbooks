service "redis" do
	action :stop
end

file "/etc/redis.conf" do
        action :delete
end

template "/etc/redis.conf" do
	action :create
	source "redis.conf"
	group "root"
	owner "root"
	mode "644"
end

service "redis" do
        action :start
end
