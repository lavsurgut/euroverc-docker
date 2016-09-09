#!/bin/bash
set -e

# workaround to set rights for usb devices
# otherwise it is not possible to write as non-root
# in container
if [ "$(whoami)" != 'root' ]; then
	gosu root chmod -R 777 /dev/bus/usb
fi

exec /ros_entrypoint.sh "$@"



