VPP_GIT=$HOME/VPP
cat $VPP_GIT/vpp_cpu_faidrop_experiments/flow_monitor.dat | tail --lines 31 | head --lines 21 | awk '{print $7"\t"$14}' | awk -F "\t|:" '{if ($1>1)print $1"\t"$3}' > flow_pps.dat
