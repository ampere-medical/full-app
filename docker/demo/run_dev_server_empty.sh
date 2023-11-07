#!/bin/bash
docker run -d --name empty-dev-server dev-server-image /bin/sh -c 'while true; do sleep 3600; done'