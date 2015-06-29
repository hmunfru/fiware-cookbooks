name             'sls'
maintainer       'ATOS'
maintainer_email 'susana.gzarzosa@atos.net'
license          'All rights reserved'
description      'Installs/Configures Service Level SIEM'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.2'

depends "mysql-semanticas"
depends "database-semanticas"
depends "runit"
depends "sls-securityprobe"
