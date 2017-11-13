#! xgp DATA/fair-drop_bell64_turbo_0.1.dat DATA/fair-drop_bell64_turbo_0.2.dat DATA/fair-drop_bell64_turbo_0.3.dat DATA/fair-drop_bell64_turbo_0.4.dat DATA/fair-drop_bell64_turbo_0.5.dat DATA/fair-drop_bell64_turbo_0.6.dat DATA/fair-drop_bell64_turbo_0.7.dat DATA/fair-drop_bell64_turbo_0.8.dat DATA/fair-drop_bell64_turbo_0.9.dat DATA/fair-drop_bell64_turbo_1.0.dat DATA/fair-drop_bell64_turbo_fifo_0.1.dat DATA/fair-drop_bell64_turbo_fifo_0.2.dat DATA/fair-drop_bell64_turbo_fifo_0.3.dat DATA/fair-drop_bell64_turbo_fifo_0.4.dat DATA/fair-drop_bell64_turbo_fifo_0.5.dat DATA/fair-drop_bell64_turbo_fifo_0.6.dat DATA/fair-drop_bell64_turbo_fifo_0.7.dat DATA/fair-drop_bell64_turbo_fifo_0.8.dat DATA/fair-drop_bell64_turbo_fifo_0.9.dat DATA/fair-drop_bell64_turbo_fifo_1.0.dat 2:1
# Created the Tue Jul 11 16:30:25 CEST 2017 with:
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

set out "fraction.pdf"
set term pdf font "Times,12"
set pointsize 0.25

set key top righ
set ylabel "Fraction of packets out of total processed packets by vpp"
set xlabel "cpu_alpha"
#set format y "%.0t^.10^%T"
#set ytics 0.1
#set yran [0.2:0.8]
#set xran [0.90:1.01]
#set xtics 0.01
min(a,b)=a<b?a:b
#set key autotitle columnhead

plot \
	"rundatalpha.dat"	u 0:2:xtic(1)   t "IP4"	w  lp pt fc lc rgb "black", \
	"rundatalpha.dat"	u 0:3:xtic(1)	t "IP6"	w  lp pt fc lc rgb "blue"
