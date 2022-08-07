#!/bin/bash

sudo dnf install nfs-utils

grep '/head/NFS' /etc/exports || echo '/head/NFS   compute*(rw,async)' >> /etc/exports

sudo systemctl restart nfs-server
