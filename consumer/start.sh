#!/bin/bash

#Hostname coincide with the engine to run csparql/cquels 
#If necessary modifies /etc/hosts

export ENGINE=$(hostname)

#Pull latest version of the engine
docker pull streamreasoning/$ENGINE 
#Delete the old (untagged) one
docker rmi $(docker images -f "dangling=true" -q)

#Programmatically build the docker-compose file to run the engine 
./build

#Run the engine and cadvisor
docker-compose up --force-recreate -d

#Create dashboard on the collector vm speaking with the running grafana instance (Port 3000)
./create-dashboards.sh
