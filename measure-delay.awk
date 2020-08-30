BEGIN{
highestpacketid=0;
FS="[, : \t]";
}
{
#if (NR%2==1)
#time=$1;
#print time;
for (i=1;i<=NF;i++){
  if($i ~/>/){
  srcIP=$(i-1);
  dstIP=$(i+1);
  if(match(srcIP,"10.1.1.11.49153")){
 if(NR>=maxnr[0]) maxnr[0]=NR;
}  
  else if(match(srcIP,"10.1.1.12.49153")){
 if(NR>=maxnr[1]) maxnr[1]=NR;
}
  else if(match(srcIP,"10.1.1.13.49153")){
 if(NR>=maxnr[2]) maxnr[2]=NR;
}
  else if(match(srcIP,"10.1.1.14.49153")){
 if(NR>=maxnr[3]) maxnr[3]=NR;
}
  else if(match(srcIP,"10.1.1.15.49153")){
 if(NR>=maxnr[4]) maxnr[4]=NR;
}
  else if(match(srcIP,"10.1.1.16.49153")){
 if(NR>=maxnr[5]) maxnr[5]=NR;
}
  else if(match(srcIP,"10.1.1.17.49153")){
 if(NR>=maxnr[6]) maxnr[6]=NR;
}
  else if(match(srcIP,"10.1.1.18.49153")){
 if(NR>=maxnr[7]) maxnr[7]=NR;
}
  else if(match(srcIP,"10.1.1.19.49153")){
 if(NR>=maxnr[8]) maxnr[8]=NR;
}
  else if(match(srcIP,"10.1.1.20.49153")){#print NR;
 if(NR>=maxnr[9]) maxnr[9]=NR;#print maxnr9;
}
}
};
}#print maxnr9;
END{
for (i=0;i<=9;i++){
printf("%s\n",maxnr[i]);}
}
