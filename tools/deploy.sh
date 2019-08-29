#!/usr/bin/env bash

#########################################################################################
####################### PLEASE READ THE BELOW INSTRUCTIONS CAREFULLY ####################
###################################### PRE-REQUISITES ###################################
## SSH TRUST SETUP between SDLC Deploy Servers and Targets servers should be completed ##
###################################### PRE-REQUISITES ###################################
#########################################################################################
########### lifecyle and artifact_path are filled by  Heighliner deploy job #############
########## lifecyle is the target deployment env selected on release.cisco.com ##########
######## artifact_path is the path, where the artifact is retrieved and stored at #######
#########################################################################################


# lifecycle is choosen as first CLI argument, as defined in .codeon.yml
# lifecycle=$1
# artifact_path is choosen as second CLI argument, as defined in .codeon.yml
# artifact_path=$2