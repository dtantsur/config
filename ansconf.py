#!/usr/bin/env python3

import argparse
import os
import subprocess
import sys


parser = argparse.ArgumentParser()
parser.add_argument("inventory")
parser.add_argument("--ssh-config")
parser.add_argument("-v", "--verbose", action='store_true')
parser.add_argument("--devstack", action='store_true')
parser.add_argument("--checkout", action='store_true')
parser.add_argument("--go", action='store_true')
args = parser.parse_args()


inventory = args.inventory
if not os.path.exists(inventory):
    inventory = inventory + ','

call = ['ansible-playbook', 'configure.yml', '-i', inventory]
extra_vars = []
tags = ["untagged"]

if args.ssh_config:
    call.extend(["--ssh-common-args", "-F %s" % args.ssh_config])

if args.verbose:
    call.append('-vvvv')
if args.devstack:
    tags.append('devstack')
if args.checkout:
    tags.append('checkout')
if args.go:
    tags.append('golang')

call.extend(['--tags', ','.join(tags), '--extra-vars', ' '.join(extra_vars)])

try:
    subprocess.check_call(call)
except Exception as exc:
    sys.exit("%s: %s" % (type(exc).__name__, str(exc)))
