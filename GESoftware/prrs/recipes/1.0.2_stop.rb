service "tomcat" do
  service_name "tomcat#{node["tomcat"]["base_version"]}"
  action :stop
end

service "KARAF-service" do
  action :stop
end


