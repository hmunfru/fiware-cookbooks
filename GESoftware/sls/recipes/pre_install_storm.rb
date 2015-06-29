
execute "wget-zeromq" do
  cwd "#{node['sls']['install_dir']}"
  command "wget http://repositories.testbed.fi-ware.org/webdav/sls/zeromq-2.2.0.tar.gz"
end

execute "untar-zeromq" do
  cwd node["sls"]["install_dir"]
  command "tar -zxvf zeromq-2.2.0.tar.gz" 
end

execute "install-zeromq" do
  cwd "#{node["sls"]["install_dir"]}/zeromq-2.2.0"
  command "cd #{node["sls"]["install_dir"]}/zeromq-2.2.0;./configure; make; make install;ldconfig" 
end

execute "wget-jdk1.6" do
   cwd "#{node["sls"]["install_dir"]}"
   command "wget http://repositories.testbed.fi-ware.org/webdav/sls/jdk1.6.0_37.tar.gz"
end

execute "untar-jdk1.6" do
  cwd node["sls"]["install_dir"] 
  command "tar -zxvf jdk1.6.0_37.tar.gz -C /usr/local"
end

execute "wget-jzmq-master" do
   cwd "#{node['sls']['install_dir']}"
   command "wget http://repositories.testbed.fi-ware.org/webdav/sls/jzmq-master.zip"
end

execute "unzip-jzmq" do
  cwd node["sls"]["install_dir"]
  command "unzip -o jzmq-master.zip"
end

execute "mod-jzmq" do
  cwd "#{node["sls"]["install_dir"]}/jzmq-master/src"
  command "touch classdist_noinst.stamp"
end

execute "install-jzmq" do
  cwd "#{node["sls"]["install_dir"]}/jzmq-master/src"
  command "CLASSPATH=.:./.:$CLASSPATH javac -d . org/zeromq/ZMQ.java org/zeromq/ZMQException.java org/zeromq/ZMQQueue.java org/zeromq/ZMQForwarder.java org/zeromq/ZMQStreamer.java;export JAVA_HOME=/usr/local/jdk1.6.0_37; cd #{node["sls"]["install_dir"]}/jzmq-master; ./autogen.sh; ./configure; make; make install; ldconfig"
end

cookbook_file "/etc/java-6-openjdk/security/java.security" do
   source "java.security-6"
   mode 644
   owner "root" 
   group "root" 
end

cookbook_file "/etc/java-7-openjdk/security/java.security" do
   source "java.security-7"
   mode 644
   owner "root"
   group "root"
end

