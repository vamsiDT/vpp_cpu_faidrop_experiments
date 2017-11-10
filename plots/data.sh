WORKDIR="/home/vk/vpp_cpu_faidrop_experiments"
BW=0.90

until  [ $(echo $BW | awk -F "." '{print $1}') -gt 0 -a $(echo $BW | awk -F "." '{print $2}') -eq 1  ]
do
	A1=$(sed '1q;d' "$BW"_run.dat | awk '{print $6}' | awk -F "." '{print $1}')
	A2=$(sed '2q;d' "BW"_run.dat | awk '{print $6}' | awk -F "." '{print $1}')
	A3=$(sed '3q;d' "BW"_run.dat | awk '{print $6}' | awk -F "." '{print $1}')
	A4=$(sed '4q;d' "BW"_run.dat | awk '{print $6}' | awk -F "." '{print $1}')
	A5=$(sed '5q;d' "BW"_run.dat | awk '{print $6}' | awk -F "." '{print $1}')
	A6=$(sed '6q;d' "BW"_run.dat | awk '{print $6}' | awk -F "." '{print $1}')
	A7=$(sed '7q;d' "BW"_run.dat | awk '{print $6}' | awk -F "." '{print $1}')
	A8=$(sed '8q;d' "BW"_run.dat | awk '{print $6}' | awk -F "." '{print $1}')
	A9=$(sed '9q;d' "BW"_run.dat | awk '{print $6}' | awk -F "." '{print $1}')
	A10=$(sed '10q;d' "BW"_run.dat | awk '{print $6}' | awk -F "." '{print $1}')
	A11=$(sed '11q;d' "BW"_run.dat | awk '{print $6}' | awk -F "." '{print $1}')
	A12=$(sed '12q;d' "BW"_run.dat | awk '{print $6}' | awk -F "." '{print $1}')

    BW=$(python -c "print($BW+0.01)")
done

echo "################################"
echo -e "\n"
echo "SUCCESSFULLY FINISHED EXPERIMENT"
echo -e "\n"
echo "################################"
