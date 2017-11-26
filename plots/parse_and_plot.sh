#!/bin/bash


cat ../flowvqueue.distr.vec | awk '{print $3}' | sort  | uniq > flows.dat

for i in `cat flows.dat`; do
	cat ../flowvqueue.distr.vec | awk '{print NR-1, $0}' | grep $i > f_$i.DATA
done
