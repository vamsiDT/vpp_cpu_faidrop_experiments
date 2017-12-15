#IMPORTANT: Configure pktgen with number of flows before running the experiment
ELOG=$1 #ELOG 1 means no elog; ELOG 0 means elog is enabled.
SCRIPTS="/home/vk/scripts_cpu"
EXP="/home/vk/vpp_cpu_faidrop_experiments"
COST=6300
#EXP=$(pwd)
FLOW="/home/vk/FLOW_MONITOR/DPDK-FlowCount"  #/home/vk/FLOW_MONITOR_INST/FlowMon-DPDK-sample
if [[ $ELOG -eq 1 ]];then
echo "NO ELOG"
else
echo "ELOG"
fi

sudo killall FlowCount
sudo killall vpp_main
sudo killall pktgen
cd $EXP
sudo rm ./*.dat
sudo rm flowvqueue*
cd $FLOW
sudo -E ./build/FlowCount -l 38,39,40 --file-prefix flow --socket-mem 4096,4096 -b $LC1P1 -b $LC1P0 -b $LC0P0 >$EXP/flow_monitor.dat &
sleep 30
cd $VPP_ROOT
sudo make build-release
sudo -E $SCRIPTS/vpp_ctl.sh
#sudo $SFLAG $BINS/vppctl -p vpp2 set dpdk interface placement TenGigabitEthernet84/0/1 queue 1 thread 1
#sudo $SFLAG $BINS/vppctl -p vpp2 set dpdk interface placement TenGigabitEthernet84/0/0 queue 1 thread 1

if [[ $ELOG -eq 1 ]];then
echo "NO ELOG"
sudo -E $SCRIPTS/pktgen_vpp_default.sh
else
echo "ELOG"
sudo -E $SCRIPTS/pktgen_capture.sh
fi
sudo cp /tmp/show $EXP/showrun.dat
sudo cp /tmp/data $EXP/showint.dat

cat $EXP/flow_monitor.dat | tail --lines 31 | head --lines 21 | awk '{print $7"\t"$14}' | awk -F "\t|:" '{if ($1>1){if(($3==4157820474)||($3==2122681738)){print $1"\t"$3"\t'$COST'"}else print $1"\t"$3"\t"350}} ' |sort -rnk3 > $EXP/plots/flow_pps.dat
echo -e "$(cat $EXP/showrun.dat | grep "vector rates" | head --lines 2 |tail --lines 1 | awk '{print $4}' | awk -F "," '{print IN = $1}')\t$(cat $EXP/showrun.dat | grep "vector rates" | head --lines 2 |tail --lines 1 | awk '{print $6}' | awk -F "," '{print IN = $1}')" > $EXP/plots/in_out.dat

cd $EXP/plots
gnuplot throughput.gp
gnuplot clk.gp
gnuplot in_out.gp
