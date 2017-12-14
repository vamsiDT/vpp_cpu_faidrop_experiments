i=350
#k=80000
DIR=$(pwd)
while [[ $i -le 7000 ]];do
for j in FAIRDROP_THF;do
if [[ $1 -eq 1 ]]; then
CLASS_1=$(cat $DIR/"$j"_"$i"/plots/flow_pps.dat | head --lines 3 | tail --lines 1| awk '{print $1}')
CLASS_2=$(cat $DIR/"$j"_"$i"/plots/flow_pps.dat | head --lines 1 | awk '{print $1}')
CLOCK_1=$(python -c "print($CLASS_1 * 350)")
CLOCK_2=$(python -c "print($CLASS_2 * $i)")
#echo -e "$j\tCLASS_1_WEIGHT:350\tCLASS_2_WEIGHT:$i\tTHROUGHPUT_CLASS_1:\t$CLASS_1\tTHROUGHPUT_CLASS_2:\t$CLASS_2\tCLOCK_1:\t$CLOCK_1\tCLOCK_2\t$CLOCK_2"

SUM=$(python -c "print($CLASS_1+$CLASS_2)")
SQ=$(python -c "print(($CLASS_1*$CLASS_1)+($CLASS_2*$CLASS_2))")
JAIN=$(python -c "print(($SUM*$SUM)/(2*$SQ))")
#echo -e "$j\t$i\tTHROUGHPUT JAIN_FAIRNESS INDEX\t$JAIN\n"

SUM1=$(python -c "print($CLOCK_1+$CLOCK_2)")
SQ1=$(python -c "print(($CLOCK_1*$CLOCK_1)+($CLOCK_2*$CLOCK_2))")
JAIN1=$(python -c "print(($SUM1*$SUM1)/(2*$SQ1))")
echo -e "$j\t$i\tTHROUGHPUT JAIN_FAIRNESS INDEX\t$JAIN\tCLOCKCYCLES JAIN_FAIRNESS INDEX\t$JAIN1"
else
D=$DIR/"$j"_"$i"/plots
cat $D/flow_pps.dat | awk -v x=$i 'BEGIN{sum=0; sq=0;}{ sum+=($1); sq+= (($1)*($1)); }END{ print ( "WEIGHT\t", x, "Throughput Fairness index\t", (sum*sum)/(NR*sq) )}'
cat $D/flow_pps.dat | awk -v x=$i 'BEGIN{sum=0; sq=0;}{ sum+=($1*$3); sq+= (($1*$3)*($1*$3)); }END{ print ( "WEIGHT\t", x, "Cycle Fairness index\t", (sum*sum)/(NR*sq) )}'
fi
done
i=$(( $i+350 ))
done
