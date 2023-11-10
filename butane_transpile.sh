#!/bin/bash

# Create a password hash for the Butane config file
docker run -it --rm quay.io/coreos/mkpasswd --method=yescrypt

# Transpile a Butane Config file into an Ignition Config file usable by Afterburn
docker run --rm -v .\butane_ignition.bu:/config.bu:z quay.io/coreos/butane:release --pretty --strict /config.bu > ignition.ign

# Encoding:
gzip+base64

# Encode the Ignition config file:
cat ignition.ign | gzip -9 | base64 -w0 -

# On Hyper-V use the kvpctl command to inject Ignition config file into a VM.
kvpctl "Fedora CoreOS 38" add-ign ignition.ign

