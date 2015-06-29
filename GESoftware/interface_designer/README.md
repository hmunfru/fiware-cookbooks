interface-designer Cookbook
===========================

Installs Interface Designer GE.

Requirements
------------

#### packages
- `unzip` - Unzip the source arhives.
- `apache2` - Hosts the scripts and other web page content.

Usage
-----

Include `interface-designer` in your node's `run_list`. This will run the default installation to the local apache.

Installation is done to path `/interface-designer` on the apache web server.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[interface-designer]"
  ]
}
```

License and Authors
-------------------
Licenced under Apache 2. Authored by Adminotech Oy.