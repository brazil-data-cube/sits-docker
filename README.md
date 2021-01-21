# SITS Docker Images <img src=".github/sits-docker-sticker.png" align="right" width="150"/>

This is the official repository of the [SITS R package](https://github.com/e-sensing/sits) Docker images. 

## Build images

To build the images contained in this repository, it is possible to use the `build.sh` utility script. This script presents options for the customization of the images generated for the use of the SITS package. The script has the following options that can be used to customize the generated images:

- `-n`: Build with `--no-cache` flag (Default uses pre-built image cache).  
- `-t`: SITS Tag version used in generated image (Default is `0.9.8`).
- `-p`: Image name prefix (Default is `bdc`).
- `-e`: SITS environment type (`full` or `minimal`. Default is `full`).
- `-h`: show a help message.

Below is an example of using the script that builds the images with `Ubuntu 20.04`, `R 4.0.3`. The tag name defined for the SITS image is 0.9.8.

```shell
./build.sh -n -p bdc -t 0.9.8
```

The above command will create the following images:

```shell
docker image ls | grep sits
```

```
TO BE DONE
```

## Running Containers

After the build of the images, they are ready to be used. Below is an example of the use of each of the defined images. Note that depending on the way the images were created, the commands below may undergo minor changes.

### Ubuntu container with SITS Package

This command opens a shell terminal in an Ubuntu container with the SITS package installed:

```shell
docker run -it \
           --name my-sits-ubuntu \
           --volume ${PWD}/data:/data \
           --volume ${PWD}/scripts:/scripts \
           bdc/sits-ubuntu-20.04-r-4.0.3:0.9.8
```

### RStudio container with SITS Package

This command runs an instance of RStudio Server (Community) with the SITS package installed.

```shell
docker run --detach \
           --publish 127.0.0.1:8787:8787 \
           --name my-sits-rstudio \
           --volume ${PWD}/data:/data \
           --volume ${PWD}/scripts:/scripts \
           bdc/sits-0.9.8-rstudio:1.4
```

Open the URL `http://127.0.0.1:8787` in a web browser:

```shell
firefox http://127.0.0.1:8787
```