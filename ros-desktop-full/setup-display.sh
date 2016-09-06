#!/bin/bash

# This simple wrapper allows ROS desktop container to access host
# xhost. Access is granted only to the running container

# It uses hostname set up in docker_compose.yml
# change it, if you changed the hostname

# Open up xhost for our container only
xhost +local:desktop



