#!/bin/bash env
docker node ls | grep Ready | wc -l | awk '{print "Number of docker nodes: " $1}'
docker stack ls | awk '{print $2}' | grep [0-9]* | sort | uniq -c | awk '{s+=$1*$2; print "- " $1 " stacks of " $2 " containers"} END {print "Total running containers: " s}'
