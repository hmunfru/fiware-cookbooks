# File: cosmos/recipes/install_mysqld.rb
# Cookbook: cosmos
# Recipe: install_mysqld
# Author: Francisco Romero Bueno
# Contact: frb@tid.es
# Description: Install a MySQL server.
#
# License...

# Install the mysql_server package if not yet installed
package "mysql_server"
