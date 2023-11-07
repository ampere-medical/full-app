#!/bin/bash
# Read each line from the secrets file and create environment variables
while IFS=':' read -r user pass; do
  case $user in
    ryen)
      RYEN_PASSWORD=$pass
      ;;
    devuser)
      DEVUSER_PASSWORD=$pass
      ;;
    root)
      ROOT_PASSWORD=$pass
      ;;
  esac
done < ./env/secrets.txt

echo $RYEN_PASSWORD
echo $DEVUSER_PASSWORD
echo $ROOT_PASSWORD

# Run the docker command with the environment variables
docker run -d -p 2222:22 -v myapp-dev-volume:/app --name myapp-dev-image-instance-one -e RYEN_PASSWORD=$RYEN_PASSWORD -e DEVUSER_PASSWORD=$DEVUSER_PASSWORD -e ROOT_PASSWORD=$ROOT_PASSWORD myapp-dev-image
