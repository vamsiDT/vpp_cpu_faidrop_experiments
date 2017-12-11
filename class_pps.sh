i=350
DIR=/home/vk/vpp_cpu_faidrop_experiments/
while [[ $i -lt 5000 ]];do
for j in FAIRDROP NOFAIRDROP FAIRDROPLOL;do
CLASS_1=$(cat $DIR/"$j"_"$i"/plots/flow_pps.dat | head --lines 3 | tail --lines 1| awk '{print $1}')
CLASS_2=$(cat $DIR/"$j"_"$i"/plots/flow_pps.dat | head --lines 1 | awk '{print $1}')
echo -e "$j\tCLASS_1_WEIGHT:350\tCLASS_2_WEIGHT:$i\tTHROUGHPUT_CLASS_1:\t$CLASS_1\tTHROUGHPUT_CLASS_2:\t$CLASS_2"
done
i=$(( $i+350 ))
done
