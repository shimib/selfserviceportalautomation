#!/bin/bash
export LC_ALL=C

#########################################
# This script creates local repositories and virtual repository that include all.
# It also creates groups and permission targets for the repositories.
# Usage: create_repos.sh team_name conf_file
#
# Pre-reqs: 
#  * need to have available:
#      dhall -- for template generation
#      curl  -- for direct REST invocations
#      jfrog -- the jfrog cli tool
#  * artifactory needs to be available and the cli pre-configured with the credentials 


check_for_dhall() {
        if ! [ -x "$(command -v dhall)" ]; then
           echo 'Error: dhall is not installed.' >&2
           exit 1
        fi
}
check_for_cli() {
        if ! [ -x "$(command -v jfrog)" ]; then
           echo 'Error: jfrog cli is not installed.' >&2
           exit 1
        fi
}
check_for_curl() {
        if ! [ -x "$(command -v curl)" ]; then
           echo 'Error: curl is not installed.' >&2
           exit 1
        fi
}
check_rt_status() {
        if ! [ `jfrog rt ping` = "OK" ]; then
           echo "Artifactory ping failed!"
           exit 1
        fi 
}
check_args() {
        if [ -z "$1" ]
        then
                echo "Missing team name argument"
                exit 1
        fi
}
###### verify dhall,curl and cli are installed
check_for_dhall
check_for_cli
check_for_curl
######
###### verify args (team)
export TEAM=$1
dry_run=$2
if [[ $* == *--dry-run* ]]
then
        dryRun=true
        echo "In Dry run. Will not update the JFrog Platform"
else
        dryRun=false
fi        
check_args $TEAM
######

# name for templates folder
now=$(date +"%F-%R")
dirName="$now-templates"
# creating the directory and generating the templates
mkdir $dirName
dhall to-directory-tree --file create-groups.dhall  --output ${dirName}
dhall to-directory-tree --file cli-templates-generator.dhall --output ${dirName}
dhall to-directory-tree --file create-permission-targets.dhall  --output ${dirName}
echo "templates generated in $dirName"
if [[ "$dryRun" = true ]]
then 
        exit 0
fi
check_rt_status
####### create local repos
echo "Creating local repositories"
for file in ${dirName}/*.local; do
  jfrog rt rc ${file}
done
####### create virtual repos
echo "Creating virtual repositories"
for file in ${dirName}/*.virtual; do
  jfrog rt rc ${file}
done
####### create groups
echo "Creating groups"
for file in ${dirName}/*.group; do
  group="$(b=${file##*/}; echo ${b%.*})"
  jfrog rt curl -X PUT -H "Content-Type: application/json" --data "@${file}" /api/security/groups/$group
done
###### create permission targets
echo "Creating permission targets"
for file in ${dirName}/*.permissiontarget; do
  permissionTarget="$(b=${file##*/}; echo ${b%.*})"
  jfrog rt curl -X PUT -H "Content-Type: application/json" --data "@${file}" /api/v2/security/permissions/$permissionTarget
done

