#!/bin/bash

# This picks up a 50 GB drive, partitions, creates fs, and mounts it.
# The partitions.txt file was taken from a similar drive:
# sfdisk -d /dev/sda > partitions.txt

Disk_size='50 GiB'

ismounted=$(df -h | grep '/head/NFS')
if [ !-z ${ismounted} ]
then
  umount /head/NFS
fi

disk=$(fdisk -l | grep "${Disk_size}" | cut -d' ' -f2 | sed -e 's/://')

sfdisk ${disk} < partitions.txt

uuid=$(blkid ${disk}1 | cut -d' ' -f2)
ftype=$(blkid ${disk}1 | cut -d' ' -f4)

if [ -z ${ftype} ] || [ ${ftype} != 'TYPE="ext4"' ]
then
 mke2fs -t ext4 ${disk}1
fi

#echo $uuid

grep ${uuid} /etc/fstab || \
 echo "${uuid}    /head/NFS   ext4   defaults  0   0" >> /etc/fstab

if [ ! -d /head/NFS ]
then
 mkdir -p /head/NFS
fi

mount -a
