cdvideoanalysis Cookbook
========================
TODO: Enter the cookbook description here.

To update cookbook with new version, do following:
- 'repack' install package (e.g. codoan_v1.4.0.zip) into cdva_resources.tar.gz (same structure) and move it to cdvideoanalysis/files/default
- update cdvideoanalysis/metadata.rb (version info)
- update cdvideoanalysis/recipes/1.0.0_uninstall.rb, 1.0.0_install.rb, 1.0.0_start.rb, 1.0.0_stop.rb (if necessary)

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
#### packages
- `toaster` - cdvideoanalysis needs toaster to brown your bagel.

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### cdvideoanalysis::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['cdvideoanalysis']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### cdvideoanalysis::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `cdvideoanalysis` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[cdvideoanalysis]"
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
