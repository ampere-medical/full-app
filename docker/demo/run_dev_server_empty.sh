#!/bin/bash
fullchainpath=/$(realpath ./env/fullchain.pem)
privpath=/$(realpath ./env/privkey.pem)
docker run -d --name empty-dev-server -v $fullchainpath:/app/env/fullchain.pem -v $privpath:/app/env/privkey.pem dev-server-image bash -c 'while true; do sleep 3600; done'