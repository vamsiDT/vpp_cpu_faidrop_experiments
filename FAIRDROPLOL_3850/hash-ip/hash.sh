I=0
FILE="/home/vk/vpp_cpu_faidrop_experiments/hash.pkt"
echo "set 0 count 1" > $FILE
echo "set 0 rate 1" >> $FILE

until  [ $I -eq 256 ]
do
	echo "set 0 ip src 192.168.0.$I/24" >> $FILE
	echo "start 0" >> $FILE
	echo "delay 1000" >> $FILE
    I=$(python -c "print($I+1)")
done
