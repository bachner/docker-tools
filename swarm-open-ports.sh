#!/bin/bash
docker stack ls | grep -v NAME | cut -d" " -f1 | while read line; do echo $(docker stack services $line | grep -P '[1-9]+[0-9]*->[1-9]+[0-9]*' | tr -s [:space:] | cut -d" " -f2,6  | sed 's/.*:\([0-9]*\).*/\1/') ; done
