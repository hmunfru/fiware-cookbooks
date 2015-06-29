
script "Tomcat stop" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  export JRE_HOME=/usr/lib/jvm/java-6-sun-1.6.0.26
  test -d $JRE_HOME || export JRE_HOME="$(dirname $(dirname $(readlink -f $(which java))))"
  #{node[:tomcat][:tomcat_home]}/bin/shutdown.sh
  EOH
end
