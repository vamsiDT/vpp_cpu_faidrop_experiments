SCRIPTS="/home/vk/scripts_cpu"
EXP="/home/vk/vpp_cpu_faidrop_experiments"
FLOW="/home/vk/FLOW_MONITOR/DPDK-FlowCount"
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
sudo $SFLAG $BINS/vppctl -p vpp2 set dpdk interface placement TenGigabitEthernet84/0/1 queue 1 thread 1
sudo $SFLAG $BINS/vppctl -p vpp2 set dpdk interface placement TenGigabitEthernet84/0/0 queue 1 thread 1
sudo -E $SCRIPTS/pktgen_capture.sh
cp /tmp/show $EXP/showrun.dat
cp /tmp/data $EXP/showint.dat

