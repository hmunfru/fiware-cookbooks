cookbook_file "map.js" do
  path "/var/lib/tomcat7/webapps/gis_test_client/scripts/map.js"
  action :create
end

cookbook_file "index.xhtml" do
  path "/var/lib/tomcat7/webapps/gis_test_client/index.xhtml"
  action :create
end
