#!/bin/bash
# This script removing all services that does not have an active branch
# all services must have a precontracted prefix which should be passed to the script as 1st parameters.
# the second parameter is the git hub repository: i.e. facebook/react is the suitable repository for: https://github.com/facebook/react

# Input validation
if [ -z $1 ] || [ -z $2 ]; then
  echo "Please pass docker service prefix name and the github repository. ( i.e. $0 react facebook/react )"
  exit 1
fi

STACK_PREFIX=$1
REPOSITORY=$2
echo STACK_PREFIX=$1
echo REPOSITORY=$2

# Get all active branches from github for project
b=$(echo $(curl -s 'https://api.github.com/repos/$REPOSITORY/branches' | egrep -w "\"name\": \"(.*)\"" | sed 's/.*:\s\"\(.*\)\",/\1\\|/') | tr -d " ")
# Remove the last two characters which are "\|"
branches=$(echo "$b" | sed 's/.\{2\}$//')
# Delete all stale images:
proc_to_terminate=$(docker service ls | grep "$1" | grep -v "$branches" | tr -s " " | cut -d" " -f2)
echo $([ -n "$proc_to_terminate" ] && docker service rm $proc_to_terminate && docker network rm $proc_to_terminate)
