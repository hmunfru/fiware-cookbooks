# JBoss user for running the service
default['kurento']['jboss_user'] = "jboss"

# JBoss group
default['kurento']['jboss_group']= "jboss"

#JBoss install directory.
default['kurento']['jboss_home']= "/opt/jboss-as"

#JBoss download URL.
default['kurento']['dl_url']="http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz"

default['kurento']['dl_tutorial']="http://builds.kurento.org/dev/release-5.1/latest/tutorials/kurento-hello-world.zip"
default['kurento']['public_ip']=true