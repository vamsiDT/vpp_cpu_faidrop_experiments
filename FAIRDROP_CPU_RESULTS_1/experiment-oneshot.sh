WEIGHT=350
WORK=$(pwd)
FILE=$DPDK_INPUT/flow_table_cpu.h
EXP=/home/vk/vpp_cpu_faidrop_experiments
until [ $WEIGHT -gt 7000 ]
do
mkdir $WORK/NOFAIRDROP_THF_"$WEIGHT"
sed -i "s/^\(#define WEIGHT_CLASS_1 \).*/\1$WEIGHT/" $FILE
sed -i "s/^\(COST=\).*/\1$WEIGHT/" $EXP/experiment.sh
$EXP/experiment.sh 1
cp -r $EXP/* $WORK/NOFAIRDROP_THF_"$WEIGHT"/

#mkdir $WORK/FAIRDROP_LOW_"$WEIGHT"
#sed -i "s/^\(#define WEIGHT_CLASS_1 \).*/\1$WEIGHT/" $FILE
#sed -i "s/^\(COST=\).*/\1$WEIGHT/" $EXP/experiment_low.sh
#$EXP/experiment_low.sh 1
#cp -r $EXP/* $WORK/FAIRDROP_LOW_"$WEIGHT"/

WEIGHT=$(python -c "print($WEIGHT+350)")
done

sudo killall vpp_main
sudo killall pktgen

echo "FINSISHED EXPERIMENT"
