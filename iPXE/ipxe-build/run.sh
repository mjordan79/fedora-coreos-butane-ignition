#!/bin/bash

# This will build the iPXE images and it will put them in the builtimg directory.
docker run --name ipxe-build --rm -v /$(pwd)/builtimg:/builtimg mjordan79/ipxe-build:latest

