#!/bin/bash
set -e

# workaround to set rights for usb devices
# otherwise it is not possible to write as non-root
# in container
if [ "$(whoami)" != 'root' ]; then
	gosu root chmod -R 777 /dev/bus/usb
fi

#export ROS_IP=$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)

exec /ros_entrypoint.sh "$@"





