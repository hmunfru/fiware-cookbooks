#
# Cookbook Name:: EspR4FastData
# Recipe:: default
#
# Copyright 2014, ORANGE
#
# All rights reserved - Do Not Redistribute
#

bash "EspR4FastDataInstall" do
  user "root"
  cwd "/tmp"
  code <<-EOH

#!/bin/bash

echo -e "\n* STEP 1: uninstall existing java packages, if any." | tee /tmp/installEspR4FastData.log
echo -e "\n  STEP 1.1: uninstall existing packages that feature the string \"java\"." | tee -a /tmp/installEspR4FastData.log

packageNames=`dpkg --get-selections | grep -v deinstall | grep java | sed s/install//g`

if [ -z $packageNames ]
then
    echo -e "  Nothing to do: no matching packages found."
fi

for packageName in $packageNames
do
    echo -e "  Found a java related package: $packageName" | tee -a /tmp/installEspR4FastData.log
    echo -e "    * Uninstalling $packageName" | tee -a /tmp/installEspR4FastData.log

    shellCommand="apt-get -y autoremove $packageName"
    bash -c "$shellCommand" >> /tmp/installEspR4FastData.log    
    
    shellCommand="dpkg -P --force-depends $packageName"
    bash -c "$shellCommand" >> /tmp/installEspR4FastData.log    
done

echo -e "\n  STEP 1.2: uninstall existing packages that feature the string \"jdk\"." | tee -a /tmp/installEspR4FastData.log

packageNames=`dpkg --get-selections | grep -v deinstall | grep jdk | sed s/install//g`

if [ -z $packageNames ]
then
    echo -e "  Nothing to do: no matching packages found." | tee -a /tmp/installEspR4FastData.log
fi

for packageName in $packageNames
do
    echo -e "  Found a java related package: $packageName" | tee -a /tmp/installEspR4FastData.log
    echo -e "    Uninstalling $packageName" | tee -a /tmp/installEspR4FastData.log

    shellCommand="apt-get -y autoremove $packageName"
    bash -c "$shellCommand" >> /tmp/installEspR4FastData.log    
    
    shellCommand="dpkg -P --force-depends $packageName"
    bash -c "$shellCommand" | tee -a /tmp/installEspR4FastData.log
done

echo -e "\n* STEP 2: download and install Oracle java runtime environment 6." | tee -a /tmp/installEspR4FastData.log
cd /usr/local/
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jre-6u45-linux-x64.bin | tee -a /tmp/installEspR4FastData.log
chmod 755 jre-6u45-linux-x64.bin
./jre-6u45-linux-x64.bin | tee -a /tmp/installEspR4FastData.log
rm -f jre-6u45-linux-x64.bin
mv jre1.6.0_45 jre6
echo -e "export JRE_HOME=/usr/local/jre6\nexport PATH=$PATH:/usr/local/jre6/bin" > /etc/profile.d/jre.sh
chmod 755 /etc/profile.d/jre.sh
. /etc/profile.d/jre.sh
echo -e "\nInstall of Oracle java runtime environment 6 is finished." | tee -a /tmp/installEspR4FastData.log

echo -e "\n* STEP 3: download and install Apache Tomcat 6." | tee -a /tmp/installEspR4FastData.log
wget http://apache.crihan.fr/dist/tomcat/tomcat-6/v6.0.41/bin/apache-tomcat-6.0.41.tar.gz
tar -zxvf apache-tomcat-6.0.41.tar.gz | tee -a /tmp/installEspR4FastData.log
rm -f apache-tomcat-6.0.41.tar.gz
mv apache-tomcat-6.0.41 tomcat6
echo -e "export CATALINA_HOME=/usr/local/tomcat6\nexport PATH=$PATH:/usr/local/tomcat6/bin" > /etc/profile.d/tomcat.sh
chmod 755 /etc/profile.d/tomcat.sh
cat /etc/profile.d/tomcat.sh | tee -a /tmp/installEspR4FastData.log
. /etc/profile.d/tomcat.sh
env | tee -a /tmp/installEspR4FastData.log
echo -e "\nInstall of Apache Tomcat 6 is finished." | tee -a /tmp/installEspR4FastData.log

echo -e "\n* STEP 4: download and install EspR4FastData." | tee -a /tmp/installEspR4FastData.log
cd /tmp
wget --no-check-certificate https://forge.fi-ware.org/frs/download.php/1413/EspR4FastData-3.4.3-build-20140708.zip | tee -a /tmp/installEspR4FastData.log
apt-get install unzip | tee -a /tmp/installEspR4FastData.log
unzip EspR4FastData-3.4.3-build-20140708.zip | tee -a /tmp/installEspR4FastData.log
mv ./EspR4FastData-3.4.3/*.war /usr/local/tomcat6/webapps/
mv ./EspR4FastData-3.4.3/EspR4FastDataSanityCheck.jar /root/
rm -rf EspR4FastData-3.4.3-build-20140708.zip
rm -rf ./EspR4FastData-3.4.3
echo -e "\nInstallation of EspR4FastData is finished." | tee -a /tmp/installEspR4FastData.log

  EOH
end
