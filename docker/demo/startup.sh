#!/bin/bash

pip install --no-cache-dir -e /usr/local/lib/app/ampere_core/
pip install --no-cache-dir -r requirements.txt
exec python src/main.py