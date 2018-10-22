#!/usr/bin/env python

import argparse
import os
import subprocess
import sys


parser = argparse.ArgumentParser()
parser.add_argument("inventory")
parser.add_argument("--ssh-config")
parser.add_argument("-v", "--verbose", action='store_true')
parser.add_argument("-r", "--openstack-repo")
parser.add_argument("--devstack", action='store_true')
parser.add_argument("--quickstart", action='store_true')
args = parser.parse_args()


inventory = args.inventory
if not os.path.exists(inventory):
    inventory = inventory + ','

call = ['ansible-playbook', 'configure.yml', '-i', inventory]
extra_vars = []
tags = ["untagged"]

if args.quickstart:
    path = os.path.expanduser('~/.quickstart/ssh.config.ansible')
    call.extend(["--ssh-common-args", "-F %s" % path])
    tags.append('quickstart')
elif args.ssh_config:
    call.extend(["--ssh-common-args", "-F %s" % args.ssh_config])

if args.verbose:
    call.append('-vvvv')
if args.openstack_repo:
    tags.append('repos')
    if args.openstack_repo != 'master':
        extra_vars.append('openstack_release=%s' % args.openstack_repo)
    else:
        extra_vars.append('openstack_release=current-tripleo')
if args.devstack:
    tags.append('devstack')
else:
    tags.append('checkout')

call.extend(['--tags', ','.join(tags),
             '--extra-vars', ' '.join(extra_vars)])

try:
    subprocess.check_call(call)
except Exception as exc:
    sys.exit("%s: %s" % (type(exc).__name__, str(exc)))
