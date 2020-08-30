BEGIN{
highestpacketid=0;x=0;
FS="[, : \t]";
}
{
if (NR==FNR){
  for(i=0;i<=9;i++){
    if(NR==(i+1)) maxnr[i]=$1;
  }
}
if (NR!=FNR){
  for(i=0;i<=NF;i++){
    if($i ~/id/ && FNR<maxnr[0]) {
    nodeid=0;
    packetid=$(i+1);
    #print NR,packetid ;
    time=$1;#print time;
      if(endtime[nodeid,packetid]==0)
      endtime[nodeid,packetid]=time;
    }
for(k=0;k<=8;k++){
  if(maxnr[(k+1)]<1) maxnr[(k+1)]=maxnr[k]; 
  #if line(k+1) has no value,inherit the previous line's number
  else if($i ~/id/ && FNR>maxnr[k] && FNR<maxnr[(k+1)]) {
    nodeid=(k+1);
    packetid=$(i+1);
    #print NR,packetid ;
    time=$1;#print time;
      if (endtime[nodeid,packetid]==0)
      endtime[nodeid,packetid]=time;
  }
}
                    }#for
}
}
END{
for (i=0;i<=nodeid;i++){
  for(j=0;j<=400;j++){
printf("%s\n", endtime[i,j]);}}
#for(i=0;i<=9;i++)
#{print maxnr[i];}
}
