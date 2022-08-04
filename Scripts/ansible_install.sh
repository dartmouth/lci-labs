#!/bin/bash

cmd='sudo dnf install -y ansible-core'

eval ${cmd}

hosts='compute1 compute2 compute3 compute4'

for i in $hosts
do

 ssh $i  ${cmd} 

done
