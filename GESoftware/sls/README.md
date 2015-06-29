sls Cookbook
============
TODO: Enter the cookbook description here.

e.g.
This cookbook makes your favorite breakfast sandwhich.

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
#### packages
- `toaster` - sls needs toaster to brown your bagel.

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### sls::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['sls']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### sls::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `sls` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sls]"
  ]
}
```

Role Based Cluster Setup:
This cookbook relies on a cluster identification role to allow more than one sto
rm cluster to run in a single Chef environment, while not breaking Chef search.  Create a role with a name of your choosing.  The role may be left empty or you may use it to apply the your application's topology and all necessary JARs within your topology.  You will need to specify the name of this role using the node attribute ['storm']['cluster_role'], which is empty by default.  You will need to apply this cluster role to both supervisor and the nimbus/UI node in your cluster

Besides, you need to identify the type of component in the Storm cluster. The following components are allowed:
- 'standalone': to run all in just one VM (nimbus, supervisor, zookeeper)
- 'zookeeper': only a zookeeper server
- 'nimbus' or 'master': the VM will be the master node (nimbus daemon running) in the cluster
- 'supervisor' or 'worker': the VM will be a worker node (supervisor daemon running) in the cluster 

Deploy Flag:
This cookbook uses a deploy flag to prevent the application from deploying unles
s desired
and allows for an undeploy recipe to run prior to the deploy.  The deploy recipe
 will also
cleanup the state of storm and is sufficient to wipe clean any topology deploy,
although
it does not stop the actual topology (that's in the works).  Once you've applied
 the
supervisor or nimbus recipes to a node you need to have "deploy_build=true" set
in your
shell.  "sudo deploy_build=true chef-client" can be used to set the environment
variable
and run Chef in a single command.


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
