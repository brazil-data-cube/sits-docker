#
# This file is part of SITS Docker.
# Copyright (C) 2023 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.

#
# Install extra dependencies
#
install.packages(c("torch", "torchopt", "luz", "tmap"))

#
# Check the environment type
#
environment_type <- Sys.getenv("SITS_ENVIRONMENT_TYPE")
environment_type <- if (environment_type == "full") TRUE else NA

remotes::install_deps(dependencies = environment_type)
