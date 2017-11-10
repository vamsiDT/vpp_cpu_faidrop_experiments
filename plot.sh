BW=0.1
X=0
DIR=$(pwd)
#until  [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -gt 0 ]
for BW in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.9 1.0
do

	CLOCK_IP4[$X]=$(($(cat $DIR/$BW.dat | grep "dpdk-input" | awk '{print $6}'| awk -F "." '{print $1}') / 2))
	CLOCK_IP4[$X]=$((${CLOCK_IP4[$X]} + $(cat $DIR/$BW.dat | grep "TenGigabitEthernet84/0/1-outpu" | awk '{print $6}'| awk -F "." '{print $1}')))
	CLOCK_IP4[$X]=$((${CLOCK_IP4[$X]} +$(cat $DIR/$BW.dat | grep "TenGigabitEthernet84/0/1-tx" | awk '{print $6}'| awk -F "." '{print $1}')))
	CLOCK_IP4[$X]=$((${CLOCK_IP4[$X]} +$(cat $DIR/$BW.dat | grep "ip4-input-no-checksum" | awk '{print $6}'| awk -F "." '{print $1}')))
	CLOCK_IP4[$X]=$((${CLOCK_IP4[$X]} +$(cat $DIR/$BW.dat | grep "ip4-load-balance" | awk '{print $6}'| awk -F "." '{print $1}')))
	CLOCK_IP4[$X]=$((${CLOCK_IP4[$X]} +$(cat $DIR/$BW.dat | grep "ip4-lookup" | awk '{print $6}'| awk -F "." '{print $1}')))
	CLOCK_IP4[$X]=$((${CLOCK_IP4[$X]} +$(cat $DIR/$BW.dat | grep "ip4-rewrite" | awk '{print $6}'| awk -F "." '{print $1}')))

	CLOCK_IP6[$X]=$(cat $DIR/$BW.dat | grep "dpdk-input" | awk '{print $6}'| awk -F "." '{print $1}')
        CLOCK_IP6[$X]=$((${CLOCK_IP6[$X]} +$(cat $DIR/$BW.dat | grep "TenGigabitEthernet84/0/1-outpu" | awk '{print $6}'| awk -F "." '{print $1}')))
        CLOCK_IP6[$X]=$((${CLOCK_IP6[$X]} +$(cat $DIR/$BW.dat | grep "TenGigabitEthernet84/0/1-tx" | awk '{print $6}'| awk -F "." '{print $1}')))
	CLOCK_IP6[$X]=$((${CLOCK_IP6[$X]} +$(cat $DIR/$BW.dat | grep "interface-output" | awk '{print $6}'| awk -F "." '{print $1}')))
	CLOCK_IP6[$X]=$((${CLOCK_IP6[$X]} +$(cat $DIR/$BW.dat | grep "ip6-input" | awk '{print $6}'| awk -F "." '{print $1}')))
	CLOCK_IP6[$X]=$((${CLOCK_IP6[$X]} +$(cat $DIR/$BW.dat | grep "ip6-lookup" | awk '{print $6}'| awk -F "." '{print $1}')))
	CLOCK_IP6[$X]=$((${CLOCK_IP6[$X]} +$(cat $DIR/$BW.dat | grep "ip6-rewrite" | awk '{print $6}'| awk -F "." '{print $1}')))
	echo -e "$BW\t${CLOCK_IP4[$X]}\t${CLOCK_IP6[$X]}\n"
	BW=$(python -c "print($BW+0.1)")
	X=$(($X + 1))
done

echo "################################"
echo -e "\n"
echo "SUCCESSFULLY FINISHED EXPERIMENT"
echo -e "\n"
echo "################################"
