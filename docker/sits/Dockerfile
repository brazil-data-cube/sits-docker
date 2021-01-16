FROM esensing/r-geospatial:0.1

COPY install_sits.R . 
RUN Rscript install_sits.R && rm install_sits.R

COPY config.yml /usr/local/lib/R/site-library/sits/extdata/config.yml
