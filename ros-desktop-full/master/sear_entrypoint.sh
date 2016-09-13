#!/bin/bash
set -e

source "/opt/ros/${ROS_DISTRO}/setup.bash"

#export ROS_IP=$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)

exec "$@"





