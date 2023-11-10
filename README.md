# fedora-coreos-butane-ignition

This repo contains a Butane config file along with its transpiled Ignition config file used by Afterburn
to provision a Fedora CoreOS 38 system. The config file assumes you're on Hyper-V.
You also need the kvpctl tool (in the bin directory) to inject the ignition file into the VM before the first boot.
