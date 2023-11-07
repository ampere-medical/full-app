#!/bin/bash
secrets_path=/$(realpath ./env/secrets.txt)
docker run -d -p 2222:22 -v myapp-dev-volume:/app -v $secrets_path:/etc/docker-config/secrets.txt myapp-dev-image
