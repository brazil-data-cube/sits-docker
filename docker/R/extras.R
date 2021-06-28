# Install devtools, rmarkdown, knitr, testthat and Rcpp if not already available
install.packages(c("rmarkdown", "Rcpp", "knitr", 
                   "testthat", "remotes", "qpdf", "shiny"))

# check the environment type
environment_type <- Sys.getenv("SITS_ENVIRONMENT_TYPE")
environment_type <- if (environment_type == "full") TRUE else NA

remotes::install_deps(dependencies = environment_type)

# install keras
remotes::install_github("rstudio/reticulate@1.19")
remotes::install_github("rstudio/keras@v2.4.0")
