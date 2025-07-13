#!/usr/bin/env python3

import argparse
import os
import subprocess
import sys


parser = argparse.ArgumentParser()
parser.add_argument("inventory")
parser.add_argument("-v", "--verbose", action='store_true')
parser.add_argument("--devstack", action='store_true')
parser.add_argument("--checkout", action='store_true')
args = parser.parse_args()


inventory = args.inventory
if not os.path.exists(inventory):
    inventory = inventory + ','

call = ['ansible-playbook', 'configure.yml', '-i', inventory]
tags = ["untagged"]

if args.verbose:
    call.append('-vvvv')
if args.devstack:
    tags.append('devstack')
if args.checkout:
    tags.append('checkout')

call.extend(['--tags', ','.join(tags)])

try:
    subprocess.check_call(call)
except Exception as exc:
    sys.exit("%s: %s" % (type(exc).__name__, str(exc)))
