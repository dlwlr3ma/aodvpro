BEGIN{
highestpacketid=0;
loss=0;success=0;error=0;
FS="[, : \t]";
}
{
if (ARGIND==1){
  for (nodeid=0;nodeid<=9;nodeid++){
    for (receivepktid=0;receivepktid<=400;receivepktid++){
      if(FNR==(nodeid*401+receivepktid+1)) endtime[nodeid,receivepktid]=$1;
    }
  }#for
}#process receivetime.dat >> endtime

if (ARGIND==2){
  for (i=0;i<=9;i++){
    if(FNR==(i+1)) maxnrsend[i]=$1;}
}#process maxnrsend.dat >> maxnrsend[i]

if (ARGIND==3){
  for (nodeid=0;nodeid<=9;nodeid++){
    for (i=1;i<=NF;i++){
      if(maxnrsend[nodeid]<1) maxnrsend[nodeid]=maxnrsend[(nodeid-1)];
      #if line(nodeid) has no value,inherit the previous line's number
      else if($i ~/id/ && FNR<maxnrsend[nodeid] && FNR>maxnrsend[(nodeid-1)]){
      sendid=$(i+1);
      time=$1;
        if(starttime[nodeid,sendid]==0)
        starttime[nodeid,sendid]=time;
      }#else if
    }#for
  }#for
}#process send.dat >> starttime delay
}
END{
#for (i=0;i<=9;i++){printf ("%s\n",maxnrsend[i]);}
  for (nodeid=0;nodeid<=9;nodeid++){
    for (packetid=0;packetid<=400;packetid++){
      if((endtime[nodeid,packetid]-starttime[nodeid,packetid])>0){
      delay[nodeid,packetid]=endtime[nodeid,packetid]-starttime[nodeid,packetid];success++;
      }
      else if((endtime[nodeid,packetid]-starttime[nodeid,packetid])<0){delay[nodeid,packetid]=0;loss++;
      }
      else if(starttime[nodeid,packetid]!=0){error++;}
    }
  }
  print loss;print success;print error;
  for (nodeid=0;nodeid<=9;nodeid++){
    for (packetid=0;packetid<=400;packetid++){
    printf("%s %s %s %s\n",nodeid,packetid,endtime[nodeid,packetid],delay[nodeid,packetid]);
    }
  }
}
