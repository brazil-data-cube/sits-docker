#!/bin/bash
#
# This file is part of SITS Docker.
# Copyright (C) 2022 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.

# configure log files
mkdir -p /var/lib/rstudio-server/monitor/log/
chown rstudio-server:rstudio-server /var/lib/rstudio-server/monitor/log/
su rstudio-server -c 'touch /var/lib/rstudio-server/monitor/log/rstudio-server.log'

# start rstudio daemon
/usr/lib/rstudio-server/bin/rserver --server-daemonize 0 > /var/log/rstudio-server.log 2>&1
