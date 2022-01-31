#
# Satellite Image Time Series
#
sits_tag_version <- Sys.getenv("SITS_TAG_VERSION")
remotes::install_github(paste0("e-sensing/sits@", sits_tag_version), dependencies = FALSE)

#
# Satellite Image Time Series Example Datasets
#
sitsdata_commit_ref <- Sys.getenv("SITSDATA_COMMIT_REF")
remotes::install_github(paste0("e-sensing/sitsdata@", sitsdata_commit_ref), dependencies = FALSE)
