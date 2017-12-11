I=0
FILE="/home/vk/vpp_cpu_faidrop_experiments/hash-256-ip.dat"
sudo rm $FILE
J=1
until  [ $J -gt 256 ]
do

	cat hash-256.dat | head -n $J | tail -n 1 | sed "s/\$/\t192.168.0.$I/" >> $FILE
    I=$(python -c "print($I+1)")
	J=$(python -c "print($J+1)")
done
