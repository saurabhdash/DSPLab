function signal=sumsinusoid(sequence,i,S,fr,fc)
T=1;
t=0:T/10000:9999*T/10000;

index=find(S==sequence(i));
temp=mod(index,4);
temp2=floor(index/4)+1;

if(~temp)
    temp=temp+4;
    temp2=temp2-1;
end

f1=fr(temp2);
f2=fc(temp);

signal=sin(2*pi*f1*t)+sin(2*pi*f2*t);
end