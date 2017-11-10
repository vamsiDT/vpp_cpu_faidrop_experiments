WORKDIR="/home/vk/vpp_cpu_faidrop_experiments"
BW=0.91

until  [ $(echo $BW | awk -F "." '{print $1}') -ge 0 -a $(echo $BW | awk -F "." '{print $2}') -eq 92  ]
do
	cat $WORKDIR/"$BW"_run.dat | tail -n 13 > $WORKDIR/plots/"$BW"_run.dat
    BW=$(python -c "print($BW+0.01)")
done

echo "################################"
echo -e "\n"
echo "SUCCESSFULLY FINISHED EXPERIMENT"
echo -e "\n"
echo "################################"
