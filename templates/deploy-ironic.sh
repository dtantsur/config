#!/bin/bash

TEMPLATES=${1:-/usr/share/openstack-tripleo-heat-templates}
CONFIG=~/ironic-config.yaml

source ~/stackrc
if ! openstack overcloud deploy --templates $TEMPLATES \
    -e $TEMPLATES/environments/puppet-pacemaker.yaml \
    -e $TEMPLATES/environments/services/ironic.yaml \
    -e $CONFIG --ntp-server pool.ntp.org;
then
    echo DEPLOY FAILED
    openstack stack failures list overcloud
    exit 1
fi
