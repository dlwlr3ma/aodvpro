BEGIN{
sum=0;sumdelay=0;
}
{
 if($3>0.01){
 sumdelay+=$4;
 sum++;
 }
}
END{
delay=sumdelay/sum;
#print sum;print sumdelay;
print delay;
}
