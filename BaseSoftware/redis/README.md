redis Cookbook
==============
TODO: Enter the cookbook description here.

e.g.
This cookbook makes your favorite breakfast sandwhich.

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
#### packages
- `toaster` - redis needs toaster to brown your bagel.

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### redis::2.4.10_configure
<table>
  <tr>
    <td><tt>['redis']['port']</tt></td>
    <td>Port</td>
    <td>Default:</td>
    <td><tt>6379</tt></td>
  </tr>
  <tr>
    <td><tt>['redis']['bind']</tt></td>
    <td>IP Address</td>
    <td>Default:</td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['redis']['masterip']</tt></td>
    <td>IP Address of the master node</td>
    <td>Default:</td>
    <td><tt>none</tt></td>
  </tr>
  <tr>
    <td><tt>['redis']['masterport']</tt></td>
    <td>Port of the master node</td>
    <td>Default:</td>
    <td><tt>none</tt></td>
  </tr>
  <tr>
    <td><tt>['redis']['passwordmaster']</tt></td>
    <td>Password of the master node</td>
    <td>Default:</td>
    <td><tt>none</tt></td>
  </tr>
  <tr>
    <td><tt>['redis']['requirepassword']</tt></td>
    <td>Password of the database</td>
    <td>Default:</td>
    <td><tt>none</tt></td>
  </tr>
</table>

Usage
-----
#### redis::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `redis` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[redis]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
