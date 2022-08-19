
sts='compute1 compute2 compute3 compute4'

for i in $hosts
do

 ssh $i  ${cmd} 

done
