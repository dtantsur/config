#!/usr/bin/env python

import argparse
import os
import subprocess
import sys


parser = argparse.ArgumentParser()
parser.add_argument("inventory")
parser.add_argument("--ssh-config")
args = parser.parse_args()


inventory = args.inventory
if not os.path.exists(inventory):
    inventory = inventory + ','

call = ['ansible-playbook', 'configure.yml', '-i', inventory]
if args.ssh_config:
    call.extend(["--ssh-common-args", "-F %s" % args.ssh_config])

try:
    subprocess.check_call(call)
except Exception as exc:
    sys.exit("%s: %s" % (type(exc).__name__, str(exc)))
