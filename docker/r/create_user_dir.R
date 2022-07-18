#
# Getting the default path to create the user's package directory
#
userdir <- unlist(strsplit(Sys.getenv("R_LIBS_USER"), .Platform$path.sep))[1L]
 
#
# Creating the user's package directory
#
if (!dir.create(userdir, recursive = TRUE)) 
    stop(paste("unable to create directory:", userdir), domain = NA)
.libPaths(c(userdir, .libPaths()))