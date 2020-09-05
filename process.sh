#!/bin/bash

	#get general receive data
	#receivedata.len>90 and it han exact src/dst ip

tcpdump -r manet-compare-0-0.pcap -nn -tt -v udp and 'ip[2:2]>90' and dst net 10.1.1.1 and src net 10.1.1.11 >receive.dat
for((i=1;i<=9;i++))
do 
((j=i +1));
((k=i +11));
#echo $j;
#echo $k;
tcpdump -r manet-compare-$i-0.pcap -nn -tt -v udp and 'ip[2:2]>90' and dst net 10.1.1.$j and src net 10.1.1.$k >>receive.dat
done

	#get general send data
	#senddata.len>90 and it has exact src/dst ip

tcpdump -r manet-compare-10-0.pcap -nn -tt -v udp and 'ip[2:2]>90' and dst net 10.1.1.1 and src net 10.1.1.11 >send.dat
for((i=11;i<=19;i++))
do
((j=i -9));
((k=i +1));
tcpdump -r manet-compare-$i-0.pcap -nn -tt -v udp and 'ip[2:2]>90' and dst net 10.1.1.$j and src net 10.1.1.$k >>send.dat
done

	#get controlpacket
	#1. include RREQ/RREP/RERR/RREP-ACK/LPP 
	#2. for 0-49 nodes, each node only catch send packet. 
	#3. ignore general packets-> ignore icmp || get other lpp packets.

tcpdump -r manet-compare-0-0.pcap -nn -tt -v \(udp and not icmp and 'ip[2:2]<=90' and src net 10.1.1.1\) or \(udp and 'ip[2:2]>90' and src net 10.1.1.1 and dst net 10.1.1.255\) >expense.dat
for((i=1;i<=49;i++))
do
((j=i+1));
tcpdump -r manet-compare-$i-0.pcap -nn -tt -v \(udp and not icmp and 'ip[2:2]<=90' and src net 10.1.1.$j\) or \(udp and 'ip[2:2]>90' and src net 10.1.1.$j and dst net 10.1.1.255\) >>expense.dat
done

	#get lppdata
	#1. for 0-49 nodes, chose the broadcast packet, include RREQ and LPP. 
	#2. ignore RREQ, RREQ.len==56

tcpdump -r manet-compare-0-0.pcap -nn -tt -v udp and 'ip[2:2]!=56' and dst net 10.1.1.255 and src net 10.1.1.1 > lpp.dat
for((i=1;i<=49;i++))
do
((j=i+1));
tcpdump -r manet-compare-$i-0.pcap -nn -tt -v udp and 'ip[2:2]!=56' and dst net 10.1.1.255 and src net 10.1.1.$j >>lpp.dat
done

gawk -f measure-delay.awk receive.dat >maxnr.dat
gawk -f measure-delay.awk send.dat >maxnrsend.dat
gawk -f measure-delay2.awk maxnr.dat receive.dat >receivetime.dat
gawk -f measure-delay3.awk receivetime.dat maxnrsend.dat send.dat >delay.dat
gawk -f measure-other.awk expense.dat delay.dat >other.dat
sort -t$' ' -k3 -n delay.dat >delay1.dat
gawk -f measure-delay4.awk delay1.dat >delay2.dat
gawk -f measure-delay5.awk delay1.dat >>other.dat
