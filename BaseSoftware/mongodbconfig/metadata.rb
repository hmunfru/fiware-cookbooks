name              "mongodbconfig"
maintainer        "Henar"
maintainer_email  "henar@tid.es"
license           "Apache 2.0"
description       "All needed elements to work with SDC"
version           "2.2.3"

recipe "mongodb", "Installs and configures a single node mongodb instance"
recipe "mongodb::10gen_repo", "Adds the 10gen repo to get the latest packages"
recipe "mongodb::mongos", "Installs and configures a mongos which can be used in a sharded setup"
recipe "mongodb::configserver", "Installs and configures a configserver for mongodb sharding"
recipe "mongodb::shard", "Installs and configures a single shard"

depends "mongodb"
