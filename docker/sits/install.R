#
# This file is part of SITS Docker.
# Copyright (C) 2022 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.

#
# Satellite Image Time Series
# Obs: removing the user directory to install sits globally
#
sits_tag_version <- Sys.getenv("SITS_TAG_VERSION")
remotes::install_github(
  paste0("e-sensing/sits@", sits_tag_version), 
  dependencies = FALSE,
  lib = .libPaths()[!grepl(pattern = "^/home/", x = .libPaths())]
)

#
# Change the download method 
#
options(download.file.method = "wget") 

#
# Satellite Image Time Series Example Datasets
# Obs: removing the user directory to install sitsdata globally
#
sitsdata_commit_ref <- Sys.getenv("SITSDATA_COMMIT_REF")
remotes::install_github(
    paste0("e-sensing/sitsdata@", sitsdata_commit_ref), 
    dependencies = FALSE,
    lib = .libPaths()[!grepl(pattern = "^/home/", x = .libPaths())]
)
