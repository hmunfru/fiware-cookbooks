symfony Cookbook
================
TODO: Enter the cookbook description here.

e.g.
This cookbook makes your favorite breakfast sandwhich.

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
#### packages
- `toaster` - symfony needs toaster to brown your bagel.

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### symfony::1.4.21_install
<table>
  <tr>
    <th>['symfony']['project']</th>
    <th>String</th>
    <th>Project Name</th>
    <th>Default: myproject</th>
  </tr>
  <tr>
    <td><tt>['symfony']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Check
-----

To check that Symfony is correctly installed, please, check with the folow commands:

cd /home/sfprojects/myproject
php lib/vendor/symfony/data/bin/check_configuration.php
php lib/vendor/symfony/data/bin/symfony -V

