#include_recipe "tomcat::application"
if  node["tomcat"] != nil

  if node["tomcat"]["path"] !=  nil
    node.default['tomcat']['path'] = node["tomcat"]["path"] 
     end
  if node["tomcat"]["application_name"] !=  nil
    node.default['tomcat']['application_name'] = node["tomcat"]['application_name']
  end
  if node["tomcat"]["database"] !=  nil
    node.default['tomcat']['database'] = node["tomcat"]['database']
  end
 
end




application node["tomcat"]["application_name"]  do
  path "/path"
  repository node["tomcat"]["path"]
  owner node["tomcat"]["user"]
  group node["tomcat"]["group"]
  revision "6facd94e958ecf68ffd28be371b5efcb5584c885b5f32a906e477f5f62bdb518-1"
        strategy :java_remote_file

#  revision ""
 #       strategy :java_local_file


 tomcat_java_webapp do
    database_master_role node['tomcat']['id_web_server']
    database do
      driver 'org.gjt.mm.mysql.Driver'

      database "#{node["tomcat"]["database"]}"
      
      port 5678
      username 'root'
      password 'mysql321go'
      max_active 1
      max_idle 2
      max_wait 3
    end
  end

  tomcat_tomcat
end
