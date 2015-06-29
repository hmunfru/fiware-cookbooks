synchronization Cookbook
========================
This cookbook installs the Synchronization GE. It consists of a Tundra server
which is a native application installed, as well as JavaScript client files.

The Tundra server will be installed to /opt/realxtend-tundra. cd to that
directory and execute xvfb-run ./Tundra --headless to run Tundra. Add command
line parameters as necessary; refer to the instructions in

https://forge.fi-ware.org/plugins/mediawiki/wiki/fiware/index.php/Synchronization_-_User_and_Programmers_Guide

Requirements
------------
A 64-bit Debian-based system is required. Ubuntu 14.04 LTS (64bit) has been 
tested to work.
Apache will be installed to serve the JavaScript client files.
xvfb will be installed to support running Tundra server as headless without 
a GPU.

Attributes
----------
TODO: List your cookbook attributes here.

e.g.
#### synchronization::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['synchronization']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### synchronization::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `synchronization` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[synchronization]"
  ]
}
```

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
