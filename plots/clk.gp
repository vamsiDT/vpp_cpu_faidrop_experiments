#! xgp flow_pps.dat
# Created the Fri Dec  8 02:30:12 CET 2017 with:
#   ____________________________
#  /                            \
# /        xgp        __________/
# \__________________/.:nonsns:.
#
 
#-------------------------------------
# SHAPES:
# (c)ircle  (t)riangle (i)nv.tri.
#           (d)iamond  (s)quare
# FILLING:
# (f)illed  (o)paque  (e)mpty (default)
#-------------------------------------
   s=4  ; es=s  ; fs=s+1 ; os=s+66
   c=6  ; ec=c  ; fc=c+1 ; oc=os+1
   t=8  ; et=t  ; ft=t+1 ; ot=oc+1
   i=10 ; ei=i  ; fi=i+1 ; oi=ot+1
   d=12 ; ed=d  ; fd=d+1 ; od=oi+1
   p=14 ; ep=p  ; fp=p+1 ; op=od+1
#-------------------------------------
#  e.g.:  
#  empty circles vs filled squares
#  plot "file" u 1:3 w p pt ec, 
#           "" u 1:4 w lp pt fs
#-------------------------------------

#Happy gnuplotting


set out "clk.pdf"
set term pdf font "Times,10"
#set pointsize 1.25

set key top righ
#set ylabel "Per flow rate [pps]"
set xlabel "Flow rank"
set xtics 1
set boxwidth 0.25
set style fill solid
#set format y "%.0t^.10^%T"
#set ytics 100000
set yran [0:2*1e8]
#min(a,b)=a<b?a:b

plot \
'flow_pps.dat'  u ($0+1):($1*$3) t 'Cycles/sec per Flow'	w  boxes
