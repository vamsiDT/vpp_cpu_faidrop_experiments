WORKDIR="/home/vk/vpp_cpu_faidrop_experiments"
SCRIPTS="/home/vk/scripts_cpu"
BW=0.97

sudo killall vpp_main
sudo killall pktgen

#CHECK DPDK-SETUP BEFORE RUNNING THE EXPERIMENT#

######################WIthout cpu turbo boost#####################


echo "disabling turbo boost"
echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo

until  [ $(echo $BW | awk -F "." '{print $1}') -ge 0 -a $(echo $BW | awk -F "." '{print $2}') -eq 98  ]
do
    echo -e "\n\n\nPerforming experiment for Bandwidth limit $BW factor of cpu 2.6Ghz\n\n\n"
    sleep 3
    sudo rm /dev/hugepages/*
    echo 60 | sudo tee /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
    sudo -E $SCRIPTS/change-bw-limit.sh 1 $BW #check this line
	cd $VPP_ROOT
    make build-release
    echo -e "\n\n\nStarting VPP in l3 forwarding mode with $NAMELC1P0 (Receiving interface) and $NAMELC1P1 (Transmitting Interface)\n\n\n"
    sleep 3
    $SCRIPTS/vpp_l3.sh &
    sleep 20
    sudo -E $SCRIPTS/ctl.sh
    echo -e "\n\n\nStarting Dpdk-Pktgen with $LC0P0 (Transmitting Interface) and $LC0P1 (Receiving Interface)\n\n\n"
    #screen -L
    $SCRIPTS/pktgen_capture.sh
    sudo killall vpp_main
    sudo killall pktgen
    cp /tmp/show $WORKDIR/"$BW"_run.dat
	cp /tmp/data $WORKDIR/"$BW"_int.dat
    BW=$(python -c "print($BW+0.01)")
done

echo "################################"
echo -e "\n"
echo "SUCCESSFULLY FINISHED EXPERIMENT"
echo -e "\n"
echo "################################"
