WEIGHT=350
WORK=$(pwd)
FILE=$DPDK_INPUT/flow_table_cpu.h
EXP=/home/vk/vpp_cpu_faidrop_experiments
until [ $WEIGHT -gt 5000 ]
do
mkdir $WORK/FAIRDROPELOG_"$WEIGHT"
sed -i "s/^\(#define WEIGHT_CLASS_1 \).*/\1$WEIGHT/" $FILE
sed -i "s/^\(COST=\).*/\1$WEIGHT/" $EXP/experiment.sh
$EXP/experiment.sh 0
cp -r $EXP/* $WORK/FAIRDROPELOG_"$WEIGHT"/
WEIGHT=$(python -c "print($WEIGHT+350)")
done

sudo killall vpp_main
sudo killall pktgen

echo "FINSISHED EXPERIMENT"
