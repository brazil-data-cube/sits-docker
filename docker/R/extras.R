
# Install devtools, rmarkdown, knitr, testthat and Rcpp if not already available
install.packages(c("rmarkdown", "Rcpp", "knitr", "testthat", "remotes"))

# Please install the Suggested packages that are used by sits
install.packages(c("DBI","dendextend", "dtwclust","dtwSat", "e1071", "flexclust",
                  "imager", "imputeTS", "kohonen", "lwgeom", "MASS", "methods",
                  "mgcv", "nnet", "proto", "proxy", "ptw", "ranger", "RCurl",
                  "RSQLite", "signal", "xgboost", "zoo", "randomForest", "desc",
                  "slider", "terra"))

# install keras
remotes::install_github("rstudio/reticulate@7174f745626d3e71a9527a96d56075a729b6506e")
remotes::install_github("rstudio/keras@aaddf0e411f66d48f88f858d1436c1d38e13fb97")
