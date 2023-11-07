#!/bin/bash
# This is docker-entrypoint.sh
while IFS=':' read -r user pass; do
  case $user in
    ryen)
      echo "ryen:$pass" | chpasswd
      ;;
    devuser)
      echo "devuser:$pass" | chpasswd
      ;;
    root)
      echo "root:$pass" | chpasswd
      ;;
  esac
done < /etc/docker-config/secrets.txt

# Execute the CMD from the Dockerfile or command line
exec "$@"

