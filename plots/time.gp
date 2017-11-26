set terminal svg size 2000,500
set output "flows.svg"

set samples 10000

LINEMIN=0
LINEMAX=200
THRESHOLD=5000


#create a function that accepts linenumber as first arg
#an returns second arg if linenumber in the given range.
InRange(x,y)=((x>=LINEMIN) ? ((x<=LINEMAX) ? y:1/0) : 1/0)
FILES = system("ls -1 *.DATA")

plot for [data in FILES] data u (InRange($0,$0)):7 w l lw 2 notitle, THRESHOLD w l lw 1 title "Threshold"
