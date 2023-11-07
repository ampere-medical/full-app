#!/bin/bash

# winpty is only if you're executing this on windows
winpty docker exec -it $1 bash
