#!/bin/bash
tcpdump -r manet-compare-0-0.pcap -nn -tt -v udp and 'ip[2:2]>90' and dst net 10.1.1.1 and src net 10.1.1.11 >receive.dat
for((i=1;i<=9;i++))
do 
((j=i +1));
((k=i +11));
#echo $j;
#echo $k;
tcpdump -r manet-compare-$i-0.pcap -nn -tt -v udp and 'ip[2:2]>90' and dst net 10.1.1.$j and src net 10.1.1.$k >>receive.dat
done

tcpdump -r manet-compare-10-0.pcap -nn -tt -v udp and 'ip[2:2]>90' and dst net 10.1.1.1 and src net 10.1.1.11 >send.dat
for((i=11;i<=19;i++))
do
((j=i -9));
((k=i +1));
tcpdump -r manet-compare-$i-0.pcap -nn -tt -v udp and 'ip[2:2]>90' and dst net 10.1.1.$j and src net 10.1.1.$k >>send.dat
done

tcpdump -r manet-compare-0-0.pcap -nn -tt -v udp and not icmp and 'ip[2:2]<=90' and src net 10.1.1.1 >expense.dat
for((i=1;i<=49;i++))
do
((j=i+1));
tcpdump -r manet-compare-$i-0.pcap -nn -tt -v udp and not icmp and 'ip[2:2]<=90' and src net 10.1.1.$j >>expense.dat
done

gawk -f measure-delay.awk receive.dat >maxnr.dat
gawk -f measure-delay.awk send.dat >maxnrsend.dat
gawk -f measure-delay2.awk maxnr.dat receive.dat >receivetime.dat
gawk -f measure-delay3.awk receivetime.dat maxnrsend.dat send.dat >delay.dat
gawk -f measure-other.awk expense.dat delay.dat >other.dat
sort -t$' ' -k3 -n delay.dat >delay1.dat
gawk -f measure-delay4.awk delay1.dat >delay2.dat
gawk -f measure-delay5.awk delay1.dat >>other.dat
