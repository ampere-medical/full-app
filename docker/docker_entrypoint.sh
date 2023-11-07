#!/bin/bash
# This is docker-entrypoint.sh
echo "root:${ROOT_PASSWORD}" | chpasswd
echo "ryen:${RYEN_PASSWORD}" | chpasswd
echo "devuser:${DEVUSER_PASSWORD}" | chpasswd

unset ROOT_PASSWORD
unset RYEN_PASSWORD
unset DEVUSER_PASSWORD

# Execute the CMD from the Dockerfile or command line
exec "$@"

