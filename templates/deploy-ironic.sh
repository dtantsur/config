#!/bin/bash

set -eu

TEMPLATES=${1:-/usr/share/openstack-tripleo-heat-templates}
CONFIG=~/ironic-config.yaml

if [ -f "$TEMPLATES/environments/disable-telemetry.yaml" ]; then
    DISABLE_TELEMETRY="-e $TEMPLATES/environments/disable-telemetry.yaml"
else
    DISABLE_TELEMETRY=
fi

source ~/stackrc
if ! openstack overcloud deploy --templates $TEMPLATES \
    -e $TEMPLATES/environments/puppet-pacemaker.yaml \
    -e $TEMPLATES/environments/services/ironic.yaml \
    $DISABLE_TELEMETRY -e $CONFIG --ntp-server pool.ntp.org;
then
    echo DEPLOY FAILED
    openstack stack failures list overcloud
    exit 1
fi
