#!/bin/bash
docker run --name matchbox --net=host --restart=always -d -v /var/lib/matchbox:/var/lib/matchbox:Z -v /etc/matchbox:/etc/matchbox:Z,ro quay.io/poseidon/matchbox:v0.10.0 -address=0.0.0.0:8080 -rpc-address=0.0.0.0:8081 -log-level=debug

