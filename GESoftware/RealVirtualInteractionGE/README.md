RealVirtualInteractionGE Cookbook
====================================
Recipe installs and configures RealVirtual interaction GE to the virtual machine.

Recipe makes following actions automatically:
- apt-get update
- installs unzip and Tomcat7
- fetches realvirtualbackend from forge
- fetches realvirtualinteraction client from forge. 

After installation RVI test client can be found under tomcat7 webapps: RVI_Client

Real virtual interaction server is located /RvI_server. Server needs to be started manually:
screen java -jar /RvI_server/realvirtualinteractionbackend.jar

In order to use test client, test server simulation needs to be initiated. Simulation is started by adding "-simulate" 
to server start like following:
screen java -jar /RvI_server/realvirtualinteractionbackend.jar -simulate



Requirements
------------
Ubuntu, tested version 14.04

Usage
-----
#### Real_Virtual_Interaction_GE::x.x.x_install
Installation script setups automatically Tomcat7 to the ubuntu server. Also realvirtualinteractionbackend.jar file is 
copied to the server /RvI_server-folder. jar file is precompiled jar of the realvirtualinteraction fiware delivery. 
Sensor simulation can be launched with following command:
  java -jar realvirtualinteractionbackend.jar -simulate

Realvirtual interaction test web client can be found after installation from the tomcat7/webapps/RVI_Client.
working on the localhost url is localhost:8080/RVI_Client/.
After sensorsimulation is launched according above command, test client can connect to simulated sensor events 
by pressing "connect"-button in the web client UI.

NOTE:
Network interfaces which needs to be Up & Open in order to get Real virtual interaction work properly

UDP port: 61616 (by default)
UDP port: 61617 (only needed for testing and is by default one greater than set UDP port)
TCP port: 44445 (by default)
TCP port: 44446 (by default)



Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
