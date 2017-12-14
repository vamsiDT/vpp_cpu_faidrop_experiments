#cat $1/flow_pps.dat | awk -v i=$1 'BEGIN{sum=0; sq=0;}{ sum+=($1); sq+= (($1)*($1)); }END{ print sum, sq, NR; print ( "DIR: ", i, "Fairness index\t", (sum*sum)/(NR*sq) )}'
#cat $1/flow_pps.dat | awk -v i=$1 'BEGIN{sum=0; sq=0;}{ sum+=($1*$3); sq+= (($1*$3)*($1*$3)); }END{ print sum, sq, NR; print ( "DIR", i, "Cycle Fairness index\t", (sum*sum)/(NR*sq) )}'
i=350
while [[ $i -lt 5000 ]];do
D=/home/vk/vpp_cpu_faidrop_experiments/$1_"$i"/plots
cat $D/flow_pps.dat | awk -v j=$i 'BEGIN{sum=0; sq=0;}{ sum+=($1); sq+= (($1)*($1)); }END{ print ( "WEIGHT\t", j, "Fairness index\t", (sum*sum)/(NR*sq) )}'
cat $D/flow_pps.dat | awk -v j=$i 'BEGIN{sum=0; sq=0;}{ sum+=($1*$3); sq+= (($1*$3)*($1*$3)); }END{ print ( "WEIGHT\t", j, "Cycle Fairness index\t", (sum*sum)/(NR*sq) )}'
i=$(( $i+350 ))
done
