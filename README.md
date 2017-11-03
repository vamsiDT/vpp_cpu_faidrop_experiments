# FAIRDROP EXPERIMENTS WITH VPP
---
1. All the .dat files are the output of 'show run' command in vppctl. 
2. File names are x.dat where x is equal to ALPHACPU which is a factor multiplied with available cpu bandwidth to allow only ALPHA*BW of cpu to be used.
3. In this case only ip4 traffic is sent to vpp. Although it doesn't make much sense for fairdrop and cpu sharing between classes of trafffic, this is useful to testing purposes.
