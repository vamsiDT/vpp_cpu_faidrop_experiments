i=350
DIR=/home/vk/vpp_cpu_faidrop_experiments/
while [[ $i -lt 5000 ]];do
for j in FAIRDROP NOFAIRDROP FAIRDROPLOL;do
CLASS_1=$(cat $DIR/"$j"_"$i"/plots/flow_pps.dat | head --lines 3 | tail --lines 1| awk '{print $1}')
CLASS_2=$(cat $DIR/"$j"_"$i"/plots/flow_pps.dat | head --lines 1 | awk '{print $1}')
CLOCK_1=$(python -c "print($CLASS_1 * 350)")
CLOCK_2=$(python -c "print($CLASS_2 * $i)")
echo -e "$j\tCLASS_1_WEIGHT:350\tCLASS_2_WEIGHT:$i\tTHROUGHPUT_CLASS_1:\t$CLASS_1\tTHROUGHPUT_CLASS_2:\t$CLASS_2\tCLOCK_1:\t$CLOCK_1\tCLOCK_2\t$CLOCK_2"
done
i=$(( $i+350 ))
done
