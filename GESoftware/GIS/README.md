gis_ge Cookbook
==================
This cookbooc install GIS GE to the server. 
Installation can be launched with gis_ge::install_gis_ge
Uninstallation can be done with gis_ge::uninstall_gis_ge

Installation contains:
1. Setting up Tomcat7
2. deployment of
  a) geoserver with xml3d support
  b) Copying test asset under geoserver. Asset can be found under "FI-WARE-Assets" -folder
  c) Setting up test GIS client and modifying it to contact geoserver found in same server (installed in step a)





Requirements
------------
Ubuntu 14.04 has been used for installation verification. CentOs is not supported.


e.g.
#### packages
- `toaster` - testi_geo needs toaster to brown your bagel.

Attributes
----------
TODO: List your cookbook attributes here.

e.g.
#### testi_geo::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['testi_geo']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### testi_geo::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `testi_geo` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[testi_geo]"
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
