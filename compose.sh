#! /bin/bash

#
# @author Desroqc
# @update 2020-08-26
#
# Docker-compose manager
#
# Tested on: Ubuntu 20.04 LTS - Docker 19.03.12 - Docker-Compose 1.26.2
#

if [ -f "./yml/$1.yml" ]; then
	if [[ "$2" == "start" ]]; then
		# Start the stack
		docker-compose -f ./yml/$1.yml -p $1 up -d
	elif [[ "$2" == "stop" ]]; then
		# Stop the stack
        docker-compose -f ./yml/$1.yml -p $1 down
    elif [[ "$2" == "build" ]]; then
		# Build the new images
        docker-compose -f ./yml/$1.yml build
    elif [[ "$2" == "update" ]]; then
		# Stop, pull the latest images from Dockerhub, build local images and start the new containers
        docker-compose -f ./yml/$1.yml -p $1 down
		docker-compose -f ./yml/$1.yml pull
        docker-compose -f ./yml/$1.yml build
        docker-compose -f ./yml/$1.yml -p $1 up -d
		# Cleanup untagged images
		docker image prune -f
	else
		echo "Invalid or missing action: $2"
	fi

elif [[ "$1" == "update" ]]; then
	# For every .yml file inside the yml directory ( Move your unused .yml file in a subfolder to disable them )
	for entry in "./yml"/*.*
	do
		# Get the stack name
        filename=$(basename -- "$entry")
        filename="${filename%.*}"
		# Stop, pull the latest images from Dockerhub, build local images and start the new containers
        docker-compose -f ./yml/$filename.yml -p $filename down
		docker-compose -f ./yml/$filename.yml pull
        docker-compose -f ./yml/$filename.yml build
        docker-compose -f ./yml/$filename.yml -p $filename up -d
	done
    # Cleanup untagged images
    docker image prune -f
else
	# Are you even trying ???
	echo "Invalid or missing command: $1"
	echo "Usage: ./compose.sh service action "
fi