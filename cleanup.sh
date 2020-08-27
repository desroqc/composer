#! /bin/bash

#
# @author Desroqc
# @update 2020-08-26
#
# Docker-compose cleanup tool ( !!! Will remove all untagged and unused images !!! )
#
# Tested on: Ubuntu 20.04 LTS - Docker 19.03.12 - Docker-Compose 1.26.2
#

# Cleanup all untagged and unused images
docker image prune -a
