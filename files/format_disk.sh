#!/bin/bash

# This picks up a 50 GB drive, partitions, creates fs, and mounts it.
# The partitions.txt file was taken from a similar drive:
# sfdisk -d /dev/sda > partitions.txt

disk=$(sudo  fdisk -l | grep '50 GiB' | cut -d' ' -f2 | sed -e 's/://')

sudo sfdisk $disk < partitions.txt

uuid=$(sudo blkid ${disk}1 | cut -d' ' -f2)

mke2fs -t ext4 ${disk}1


echo $uuid

grep $uuid /etc/fstab || echo "$uuid    /head/NFS   ext4   defaults  0   0" >> /etc/fstab

if [ ! -d /head/NFS ]
then
 mkdir -p /head/NFS
fi

mount -a
