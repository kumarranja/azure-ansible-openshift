#!/bin/bash

set -euo pipefail

source ci/openstack/vars.sh
if [ "${RUN_OPENSTACK_CI:-}" != "true" ]; then
    echo RUN_OPENSTACK_CI is set to false, skipping the openstack end to end test.
    exit
fi

echo RESTORING DNS
sudo cp resolv.conf.orig /etc/resolv.conf

openstack keypair delete "$KEYPAIR_NAME" || true
openstack stack delete --wait --yes "$ENV_ID.example.com" || true
