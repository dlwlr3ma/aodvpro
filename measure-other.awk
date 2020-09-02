BEGIN{
rreq=0;rrep=0;rerr=0;pack=0;
FS="[, : \t]";
}
{
if(NR==FNR){
  for (i=1;i<=NF;i++){
    if($i =="rreq") rreq++;
    else if($i =="rrep") rrep++;
    else if($i =="rerr") rerr++;
    else if($i =="rrep-ack") pack++;
}
}
if(NR!=FNR){
  if(FNR==1) {loss=$1;print loss;}
  if(FNR==2) {success=$1;print success;}
}
}
END{print rreq;print rrep;print rerr;print pack;
sum=rreq+rrep+rerr+pack;
print sum;
expense=sum/(sum+success);
print expense;
pdr=success/(success+loss);
print pdr;}

