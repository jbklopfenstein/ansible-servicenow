#!/usr/bin/env bash

#########################################################################################
####################### PLEASE READ THE BELOW INSTRUCTIONS CAREFULLY ####################
########## This is your build script that gets executed on the Jenkins server ###########
###################### It builds your artifact in any desired format ####################
#################  It is recommended to append the Jenkins Build Number #################
################## and your repository name to your artifactory package #################
#########################################################################################



# GIT Repository name is extracted from $GIT_URL Ex: ssh://git@gitscm.cisco.com/sdlc/sample-bash.git
# reponame=$(echo $GIT_URL | awk -F/ '{print $5}'| sed 's/....$//')
# The above output returns sample-bash as the reponame

# Jenkins build number can retrieved by using the variable $BUILD_NUMBER
