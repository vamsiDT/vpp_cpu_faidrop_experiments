WORK=/home/vk/NOFAIRDROP_CPU_RESULTS
i=350;while [[ $i -le 7000 ]];do cat $WORK/NOFAIRDROP_THF_$i/plots/in_out.dat | awk -v a=$i '{print a"\t"$1"\t"$2}';i=$(( $i+350 ));done
