virtualcharacters Cookbook
==========================
This cookbook installs the VirtualCharacters Generic Enabler, which is 
JavaScript client code for animating 3D characters using WebGL, and enables it
to be served with Apache.

The client code will be installed in the VirtualCharacters subfolder of the
web root folder. To run a test of the GE (WebGL capable browser required),
open the page

http://<serveraddress>/VirtualCharacters/examples/Avatar/index.html


Requirements
------------
To demonstrate serving the VirtualCharacters JavaScript files, this cookbook
installs Apache. 


Attributes
----------
TODO: List your cookbook attributes here.

e.g.
#### virtualcharacters::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['virtualcharacters']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### virtualcharacters::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `virtualcharacters` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[virtualcharacters]"
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
