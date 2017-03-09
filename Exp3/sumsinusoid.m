function signal=sumsinusoid(sequence,i,S,fr,fc,Fs)
T=40e-3;
t=0:1/Fs:(Fs-1)*T/Fs;

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