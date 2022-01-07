#!/bin/bash

# configure log files
mkdir -p /var/lib/rstudio-server/monitor/log/
chown rstudio-server:rstudio-server /var/lib/rstudio-server/monitor/log/
su rstudio-server -c 'touch /var/lib/rstudio-server/monitor/log/rstudio-server.log'

# start rstudio daemon
/usr/lib/rstudio-server/bin/rserver --server-daemonize 0 > /var/log/rstudio-server.log 2>&1
