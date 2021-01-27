# SITS Docker Images <img src=".github/sits-docker-sticker.png" align="right" width="150"/>

[![Software License](https://img.shields.io/badge/license-MIT-green)](https://github.com//brazil-data-cube/sits-docker/blob/master/LICENSE) [![Drone build status](https://drone.dpi.inpe.br/api/badges/brazil-data-cube/sits-docker/status.svg)](https://drone.dpi.inpe.br/api/badges/brazil-data-cube/sits-docker) [![Software Life
Cycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing) [![Release](https://img.shields.io/github/tag/brazil-data-cube/sits-docker.svg)](https://github.com/brazil-data-cube/sits-docker/releases) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/brazildatacube/sits?label=Docker%20Hub)](https://hub.docker.com/r/brazildatacube/sits) [![Docker Pulls](https://img.shields.io/docker/pulls/brazildatacube/sits)](https://hub.docker.com/r/brazildatacube/sits) [![Join us at
Discord](https://img.shields.io/discord/689541907621085198?logo=discord&logoColor=ffffff&color=7389D8)](https://discord.com/channels/689541907621085198#)

This is the official repository of Docker images for the [SITS R package](https://github.com/e-sensing/sits).


## Usage

There are prepared images in Docker Hub under the repository [brazildatacube/sits](https://hub.docker.com/r/brazildatacube/sits) and [brazildatacube/sits-rstudio](https://hub.docker.com/r/brazildatacube/sits-rstudio). In order to run a basic container capable of serving from a web browser a RStudio with SITS-enabled, start a container as follows:

```shell
docker run --detach \
           --publish 127.0.0.1:8787:8787 \
           --name my-sits-rstudio \
           --volume ${PWD}/data:/data \
           --volume ${PWD}/scripts:/scripts \
           brazildatacube/sits-rstudio
```

Then, open the URL `http://127.0.0.1:8787` in a web browser:

```shell
firefox http://127.0.0.1:8787
```
> To login use `sits` as user and password.

## Building the Docker Image

To build the images with the Dockerfiles contained in this repository, it is possible to use the `build.sh` utility script. This script presents options for the customization of the images generated for the use of the SITS package. The script has the following options that can be used to customize the generated images:

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
bdc/sits-ubuntu-20.04-r-4-rstudio     0.9.8       739141bf2cd8   3 hours ago     7.13GB
bdc/sits-ubuntu-20.04-r-4             0.9.8       6dbda66e0448   3 hours ago     6.17GB
bdc/sits-ubuntu-20.04-r               4           24d51a565c89   3 hours ago     5.92GB
bdc/sits-ubuntu                       20.04       5a39c6e1312d   5 hours ago     1.29GB
```


### Running Containers

After the build of the images, they are ready to be used. Below is an example of the use of each of the defined images. Note that depending on the way the images were created, the commands below may undergo minor changes.


#### Ubuntu container with SITS Package

This command opens a shell terminal in an Ubuntu container with the SITS package installed:

```shell
docker run -it \
           --name my-sits-ubuntu \
           --volume ${PWD}/data:/data \
           --volume ${PWD}/scripts:/scripts \
           bdc/sits-ubuntu-20.04-r-4:0.9.8
```


#### RStudio container with SITS Package

This command runs an instance of RStudio Server (Community) with the SITS package installed.

```shell
docker run --detach \
           --publish 127.0.0.1:8787:8787 \
           --name my-sits-rstudio \
           --volume ${PWD}/data:/data \
           --volume ${PWD}/scripts:/scripts \
           bdc/sits-ubuntu-20.04-r-4-rstudio:0.9.8
```

Open the URL `http://127.0.0.1:8787` in a web browser:

```shell
firefox http://127.0.0.1:8787
```

> To login use `sits` as user and password.
