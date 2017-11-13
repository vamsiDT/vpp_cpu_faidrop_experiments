# FAIRDROP EXPERIMENTS WITH VPP
---
1. All the dat files are the output of 'show run' command from vppctl after 10 seconds of traffic input.
2. In this case the traffic is ip4 and ip6 mixed traffic.
3. IP4-75% IP6-25%
4. The clocks column in show run show the total clock cycles spent by a node since the last clear.
5. A busy loop of 200 clock cyles is added to ip6-lookup node to stress more clock cycles on ip6 chain.
