#IMPORTANT: Configure pktgen with number of flows before running the experiment
ELOG=$1 #ELOG 1 means no elog; ELOG 0 means elog is enabled.
SCRIPTS="/home/vk/scripts_cpu"
EXP="/home/vk/vpp_cpu_faidrop_experiments"
COST=700
#EXP=$(pwd)
FLOW="/home/vk/FLOW_MONITOR/DPDK-FlowCount"  #/home/vk/FLOW_MONITOR_INST/FlowMon-DPDK-sample

sudo killall FlowCount
sudo killall vpp_main
sudo killall pktgen
sudo killall MoonGen
cd $EXP
sudo rm ./*.dat
sudo rm flowvqueue*

if [[ $2 -eq 1 ]];then
	echo -e "\nexperiment for tx from pktgen\n"
	cd $FLOW
	sudo -E ./build/FlowCount -l 27,28,29,30,31 --file-prefix flow --socket-mem 4096,4096 -b $LC1P1 -b $LC0P1 -b $LC0P0 > $EXP/flow_monitor_tx.dat &
	sudo -E $SCRIPTS/pktgen_vpp_default.sh
	cat $EXP/flow_monitor_tx.dat | tail --lines 2011 | head --lines 2001 | awk '{print $4"\t"$12}' | awk -F "\t|:" '{if ($1>0){if(($2==4157820474)||($2==2122681738)){print $1"\t"$2}else print $1"\t"$2}} ' |sort -rnk1 > $EXP/plots/flow_pps_tx.dat
	sudo killall FlowCount
	sudo killall vpp_main
	sudo killall pktgen
	sudo killall MoonGen
else
	echo -e "\nPktgen-->VPP-->FlowMonitor\n"
	cd $FLOW
	sudo -E ./build/FlowCount -l 38,39,40 --file-prefix flow --socket-mem 4096,4096 -b $LC1P1 -b $LC1P0 -b $LC0P0 >$EXP/flow_monitor.dat &
	sleep 30
	sudo -E $SCRIPTS/vpp_ctl.sh
	#sudo $SFLAG $BINS/vppctl -p vpp2 set dpdk interface placement TenGigabitEthernet84/0/1 queue 1 thread 1
	#sudo $SFLAG $BINS/vppctl -p vpp2 set dpdk interface placement TenGigabitEthernet84/0/0 queue 1 thread 1
	ELOG=1
	if [[ $ELOG -eq 1 ]];then
	echo "NO ELOG"
	sudo -E $SCRIPTS/pktgen_vpp_default.sh
#	cd /usr/local/src/MoonGen
#	sudo ./build/MoonGen experiments_traffic/single_tx.lua --dpdk-config=/home/vk/dpdk-conf-lc0.lua 0 -f 4000 -r 10000 &
#	sleep 60
#	sudo killall MoonGen
	else
	echo "ELOG"
	sudo -E $SCRIPTS/pktgen_capture.sh
	fi
	sudo cp /tmp/show $EXP/showrun.dat
	sudo cp /tmp/data $EXP/showint.dat
#For 4000 Flows
#	cat $EXP/flow_monitor.dat | tail --lines 4009 | head --lines 4001 | awk '{print $4"\t"$12}' | awk -F "\t|:" '{if($1>0.1){print $1"\t"$2}} ' |sort -rnk1 > $EXP/plots/flow_pps.dat

#For 20 Flows
#bandwidth
	#cat $EXP/flow_monitor.dat | tail --lines 31 | head --lines 21 | awk '{print $7"\t"$14}' | awk -F "\t|:" '{if ($1>1){if(($3==4157820474)||($3==2122681738)){print $1"\t"$3"\t'$COST'"}else print $1"\t"$3"\t"350}} ' |sort -rnk3 > $EXP/plots/flow_pps.dat
#cpu fairdrop
	cat $EXP/flow_monitor.dat | tail --lines 29 | head --lines 21 | awk '{print $4"\t"$12}' | awk -F "\t|:" '{if ($1>1){if(($2==4157820474)||($2==2122681738)){print $1"\t"$2"\t'$COST'"}else print $1"\t"$2"\t"350}} ' |sort -rnk3 > $EXP/plots/flow_pps.dat
	echo -e "$(cat $EXP/showrun.dat | grep "vector rates" | head --lines 2 |tail --lines 1 | awk '{print $4}' | awk -F "," '{print IN = $1}')\t$(cat $EXP/showrun.dat | grep "vector rates" | head --lines 2 |tail --lines 1 | awk '{print $6}' | awk -F "," '{print IN = $1}')" > $EXP/plots/in_out.dat


#	cd $EXP/plots
#	gnuplot throughput.gp
#	gnuplot clk.gp
#	gnuplot in_out.gp

#	sudo killall FlowCount
#	sudo killall vpp_main
#	sudo killall pktgen
#	sudo killall MoonGen
fi
