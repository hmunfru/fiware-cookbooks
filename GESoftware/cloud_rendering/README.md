cloud-rendering Cookbook
========================
TODO: Enter the cookbook description here.

e.g.
This cookbook makes your favorite breakfast sandwich.

Requirements
------------

Installs Cloud Rendering web service and provides a daemon script to start and stop the server.

#### packages
- `unzip` - Unzip the source arhives.
- `nodejs' - Needs node as its a nodejs based server.
- `nodejs-legacy` - This package provides a sym link from 'node' to 'nodejs' executable. The old style 'node' is still used in some parts of the application.
- `grunt-cli` - Grunt is used to build and in some cases to run the application. This is installed from npm by the installation, not from the distros package manager.

Usage
-----

Include `cloud-rendering` in your node's `run_list`. This will run the default installation.

To run start use `cloud-rendering::1.0.0_start` and to stop use `cloud-rendering::1.0.0_stop`.

The web service will run on port 3000 to not conflict with any other running web servers.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[cloud-rendering]"
  ]
}
```

License and Authors
-------------------
Licenced under Apache 2. Authored by Adminotech Oy.
