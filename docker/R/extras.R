# Install devtools, rmarkdown, knitr, testthat and Rcpp if not already available
install.packages(c("rmarkdown", "Rcpp", "knitr", "testthat", "remotes", "qpdf"))

# check the environment type
environment_type <- Sys.getenv("SITS_ENVIRONMENT_TYPE")
environment_type <- if (environment_type == "full") TRUE else NA

remotes::install_deps(dependencies = environment_type)

# install keras
remotes::install_github("rstudio/reticulate@7174f745626d3e71a9527a96d56075a729b6506e")
remotes::install_github("rstudio/keras@aaddf0e411f66d48f88f858d1436c1d38e13fb97")
