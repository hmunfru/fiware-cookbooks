2d-ui Cookbook
==============

Installs 2D-UI GE.

Requirements
------------

#### packages
- `unzip` - Unzip the source arhives.
- `apache2` - Hosts the scripts and other web page content.

Usage
-----

Include `2d-ui` in your node's `run_list`. This will run the default installation to the local apache.

Installation is done to path `/2d-ui-input-api` and `/2d-ui-web-component` on the apache web server.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[2d-ui]"
  ]
}
```

License and Authors
-------------------
Licenced under Apache 2. Authored by Adminotech Oy.
