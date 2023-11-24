#!/bin/bash
docker run --name ipxe-build --rm -v /$(pwd)/builtimg:/builtimg mjordan79/ipxe-build:latest

