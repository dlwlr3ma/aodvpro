BEGIN{
rreq=0;rrep=0;rerr=0;pack=0;lpp=0;
FS="[, : \t]";
}
{
if(NR==FNR){
  for (i=1;i<=NF;i++){
    if($i =="rreq") rreq++;
    else if($i =="rrep") rrep++;
    else if($i =="rerr") rerr++;
    else if($i =="rrep-ack") pack++;
    else if($i == "type") lpp++;
}
}
if(NR!=FNR){
  if(FNR==1) {loss=$1;printf ("%-8s\t%s\n","loss:",loss);}
  if(FNR==2) {success=$1;printf ("%-8s\t%s\n","success:",success);}
}
}
END{
	printf ("%-8s\t%s\n","RREQ:",rreq);
	printf ("%-8s\t%s\n","RREP:",rrep);
	printf ("%-8s\t%s\n","RERR:",rerr);
	printf ("%-8s\t%s\n","RREP-ACK:",pack);
	printf ("%-8s\t%s\n","LPP:",lpp);
	
	sum=rreq+rrep+rerr+pack+lpp;
	printf ("%-8s\t%s\n","controlpacket:",sum);
	expense=sum/(sum+success);
	printf ("%-8s\t%s%\n","expense:",expense*100);
	pdr=success/(success+loss);
	printf ("%-8s\t%s%\n","pdr:",pdr*100);
}

