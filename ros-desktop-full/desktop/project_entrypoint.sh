#!/bin/bash
set -e

# workaround to set rights for usb devices
# otherwise it is not possible to write into usb as non-root
# in container
USB_PERMS=$(stat /dev/bus/usb | sed -n '/^Access: (/{s/Access: (\([0-9]\+\).*$/\1/;p}')

if [ "$(whoami)" != 'root' ] && [ "${USB_PERMS}" != '0777' ]; then
	gosu root chmod -R 777 /dev/bus/usb
fi

exec /ros_entrypoint.sh "$@"





