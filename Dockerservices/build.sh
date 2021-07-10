#!/bin/sh

docker build -t mrtoolapp:prd -f Dockerfile .
if [ `echo $?` == 0 ]; then
	docker rm -f mrtool
	docker run -dt --restart=always -p 8011:8011 --name mrtool mrtoolapp:prd
fi
