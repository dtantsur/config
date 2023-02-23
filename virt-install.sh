#!/bin/bash

set -eux

NAME="${1:-centos8}"
DEST="/var/lib/libvirt/images/$NAME.qcow2"
SSH_KEY="$HOME/.ssh/id_ed25519.pub"
MEMORY=${MEMORY:-24}
CPUS=${CPUS:-6}
DISK=${DISK:-100}

OS_VERSION=${2:-centosstream-9}
OS_VARIANT=${3:-centos-stream9}

mkdir -p $(dirname "$DEST")

if ! test -f "$SSH_KEY"; then
    echo "$SSH_KEY does not exist"
    ls ~/.ssh
    exit 1
fi

if sudo virsh list --all | grep -qw "$NAME"; then
    echo "$NAME is already running"
    sudo virsh destroy "$NAME" || true
    sudo virsh undefine "$NAME"
fi

TMP=$(mktemp -d)
sudo virsh net-dumpxml default > "$TMP/default.xml"
if grep -q 192.168.122 "$TMP/default.xml"; then
    echo Avoid conflict with nested VMs
    sudo sed -i 's/192.168.122/192.168.42/g' "$TMP/default.xml"
    sudo virsh net-destroy default
    sudo virsh net-define --file "$TMP/default.xml"
    sudo virsh net-start default
fi

sudo virt-builder $OS_VERSION -o "$DEST" \
    --hostname "$NAME.localdomain" \
    --size ${DISK}G \
    --format qcow2 \
    --run-command "useradd -G wheel dtantsur" \
    --ssh-inject dtantsur:file:"$SSH_KEY" \
    --write /etc/sudoers:"%wheel ALL=(ALL:ALL) NOPASSWD: ALL" \
    --update \
    --install "git,vim,python3,make,gcc" \
    --selinux-relabel

sudo virt-install \
    --name "$NAME" \
    --memory $(($MEMORY * 1024)) \
    --vcpus $CPUS \
    --os-variant $OS_VARIANT \
    --graphics none \
    --network bridge=virbr0 \
    --import \
    --disk "path=$DEST,format=qcow2" \
    --noautoconsole

sleep 30

sudo virsh net-dhcp-leases default
