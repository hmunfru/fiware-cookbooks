#!/bin/bash

> /var/log/zookeeper/version-2/log.1
for i in `ls /var/log/zookeeper/version-2/log*`
do
  > $i
done
> /opt/zookeeper/bin/zookeeper.out
/opt/zookeeper/bin/zkCleanup.sh /var/log/zookeeper -n 7

> /var/log/ossim/agent.log
> /var/log/ossim/agent_error.log
> /var/log/ossim/server.log
> /var/log/ossim/server.err
> /var/log/ossim/frameworkd.log
> /var/log/ossim/frameworkd_error.log
> /var/log/ossim/framework-notifications.log
> /var/log/ossim/idm/server.log

> /var/log/storm/nimbus.log
> /var/log/storm/supervisor.log
for i in `ls /var/log/storm/worker*`
do
  > $i
done

