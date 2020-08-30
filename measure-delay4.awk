BEGIN{
k=0;
}
{ 
  for(i=1;i<=100.5;i=i+0.5){                #i+0.5 represents the max time range
    if($3>i && $3<=(i+0.5)){
      if(delayschedule[(2*i-2),0]==0) k=0; #if receivetime's range changes,clear k
      delayschedule[(2*i-2),k]=$4;
      k++;
    }
  }
}
END{
  k=0;sumpackets=0;
  for(i=1;i<=100.5;i=i+0.5){
    while(delayschedule[(2*i-2),k]!=0){
    delaysum[(2*i-2)]+=delayschedule[(2*i-2),k];
    k++;
    }
    sumpackets+=k;
    if(k==0){delaysum[(2*i-2)]=0; delayaverage[(2*i-2)]=0;}
    else delayaverage[(2*i-2)]=delaysum[(2*i-2)]/k;
    printf("%s \t %s \t %s\n",(i+0.5),k,delayaverage[(2*i-2)]);
    k=0;
  }
 # print sumpackets;
}
