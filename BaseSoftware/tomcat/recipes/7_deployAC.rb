#include_recipe "tomcat::application"
if  node["tomcat"] != nil
  if node["tomcat"]["war"] !=  nil
    node.default['tomcat']['war'] = node["tomcat"]["war"] 
     end
  if node["tomcat"]["application_name"] !=  nil
    node.default['tomcat']['application_name'] = node["tomcat"]['application_name']
  end
 
end




application node["tomcat"]["application_name"]  do
  path "/path"
  repository "http://130.206.80.116:8080/sample.war"
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
  revision "6facd94e958ecf68ffd28be371b5efcb5584c885b5f32a906e477f5f62bdb518-1"
        strategy :java_remote_file

#  revision ""
 #       strategy :java_local_file

 tomcat_java_webapp do
    database_master_role "database_master"
    database do
      driver 'org.gjt.mm.mysql.Driver'
      database 'name'
      port 5678
      username 'user'
      password 'password'
      max_active 1
      max_idle 2
      max_wait 3
    end
  end

  tomcat_tomcat
end
