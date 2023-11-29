#!/bin/bash

# This will build the image used to build iPXE images. Used by the run.sh script.
docker build --no-cache --force-rm -t mjordan79/ipxe-build:latest .

