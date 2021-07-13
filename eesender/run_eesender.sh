#!/bin/sh


###
#arg $1: Domain whitelisting
#arg $2: Mailserver Hostname

#0. delete container

docker container rm eesender --force

#1. build container

docker build --tag eesender:1.0 .

#2. run container
docker run --rm --name=eesender -e MTP_HOST=$2 -p 127.0.0.1:25:25 \
-e ONLY_DOMAIN=$1 \
 eesender:1.0


touch docker_setup_finished

head