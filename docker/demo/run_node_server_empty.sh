#!/bin/bash
docker run -d --name empty-node-server node-server-image bash -c 'while true; do sleep 3600; done'