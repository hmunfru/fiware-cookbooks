maintainer       "ATOS / Mauricio Ciprian"
maintainer_email "mauricio.ciprian@atos.net"
license          "All rights reserved"
description      "Installs/Configures the Semantic Application Support"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

depends "tomcat-semanticas"
depends "mysql-semanticas"
depends "database-semanticas"
depends "jboss"
