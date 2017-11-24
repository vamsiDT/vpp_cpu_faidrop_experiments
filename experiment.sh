SCRIPTS="/home/vk/scripts_cpu"
EXP="/home/vk/vpp_cpu_faidrop_experiments"
FLOW="/home/vk/FLOW_MONITOR/DPDK-FlowCount"
sudo killall FlowCount
sudo killall vpp_main
sudo killall pktgen
cd $FLOW
sudo -E ./build/FlowCount -l 38,39,40 --file-prefix flow --socket-mem 4096,4096 -b $LC1P1 -b $LC1P0 -b $LC0P0 >$EXP/flow_monitor.dat &
sleep 30
cd $VPP_ROOT
sudo make build-release
sudo -E $SCRIPTS/vpp_ctl.sh
sudo -E $SCRIPTS/pktgen_capture.sh
cp /tmp/show $EXP/showrun.dat
cp /tmp/data $EXP/showint.dat

#post processing
cd $EXP
cat flow_monitor.dat | tail -l 13 > flow_throughput.dat
