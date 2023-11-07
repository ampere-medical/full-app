#!/bin/bash
docker run -d --name empty-node-server node-server-image /bin/sh -c 'while true; do sleep 3600; done'