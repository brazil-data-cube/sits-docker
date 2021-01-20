# SITS Docker Images <img src=".github/sits-docker-sticker.png" align="right" width="150"/>

This is the official repository of the [SITS R package](https://github.com/e-sensing/sits) Docker images. 

## Build images

To build the images contained in this repository, it is possible to use the `build.sh` utility script. This script presents options for the customization of the images generated for the use of the SITS package. The script has the following options that can be used to customize the generated images:

- `-n`: Build with `--no-cache` flag 
- `-r`: R version (`4.0.1`, `4.0.2`, `4.0.3`. Default is `4.0.3`)
- `-t`: SITS Tag version used in generated image (Default is `0.9.8`)
- `-p`: Image name prefix (Default is `bdc`)
- `-e`: SITS environment type (`full` or `minimal`. Default is `full`)
- `-h`: show a help message

Below is an example of using the script that builds the images with `Ubuntu 20.04`, `R 4.0.3`. The tag name defined for the SITS image is 0.9.8.

```shell
./build.sh -n -u 20.04 -r 4.0.3 -p bdc -t 0.9.8
```

## Examples

After the build of the images, they are ready to be used. Below is an example of the use of each of the defined images. Note that depending on the way the images were created, the commands below may undergo minor changes.

**Running a Ubuntu container with the base packages for the installation of SITS**

This container is recommended for developing the SITS package since it is possible to customize the package installation and its dependencies.

```shell
docker run -it \
           --name ubuntu-to-install-sits \
           --volume ${PWD}/data:/data \
           --volume ${PWD}/scripts:/scripts \
           bdc/sits-ubuntu-20.04-r:4.0.3
```

**Running a Ubuntu container with SITS Package**

This command runs an Ubuntu container with the SITS package installed and ready to use.

```shell
docker run -it \
           --name ubuntu-sits \
           --volume ${PWD}/data:/data \
           --volume ${PWD}/scripts:/scripts \
           bdc/sits-ubuntu-20.04-r-4.0.3:0.9.8
```

**RStudio for SITS R Package**

This command runs an instance of RStudio Server (Community) with the SITS package installed.

```shell
docker run --detach \
           --publish 127.0.0.1:8787:8787 \
           --name my-sits-rstudio \
           --volume ${PWD}/data:/data \
           --volume ${PWD}/scripts:/scripts \
           bdc/sits-0.9.8-rstudio:1.4
```
