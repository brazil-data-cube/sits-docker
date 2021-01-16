# SITS Docker image

This documennt contains instructions for installing SITS using the Docker image.


./build.sh -n -s -u 20.04 -r 4.0.3 -p bdc -t 0.9.8


docker run --detach \
           --publish 127.0.0.1:8787:8787 \
           --name my-sits-rstudio \  
           --volume ${PWD}/data:/data \
           --volume ${PWD}/scripts:/scripts \          
           bdc/sits-0.9.8-rstudio:1.4
           
           
docker run -it \
           --name my-sits \  
           --volume ${PWD}/data:/data \
           --volume ${PWD}/scripts:/scripts \
           bdc/sits-ubuntu-20.04-r:4.0.3 \
           R


docker run -it \
           --name my-sits \  
           --volume ${PWD}/data:/data \
           --volume ${PWD}/scripts:/scripts \           
           bdc/sits-ubuntu-20.04-r:4.0.3 \
           Rscript /scripts/my-script.R 