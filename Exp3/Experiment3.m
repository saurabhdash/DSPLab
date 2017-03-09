clear;
clc;
fr = [697 770 852  941];
fc = [1209 1336 1447 1633];
S='123A456B789C*0#D';
Fs=8e3;
T=40e-3;
str='4A*DB371*5';
t=0:1/Fs:(length(str)*Fs-1)*T/Fs;
y=zeros(1,8);
keys=zeros(1,length(str));
power=zeros(1,4);

for i=1:length(str)
    y(:)=0;
    signal=sumsinusoid(str,i,S,fr,fc,Fs);  %signal corresponding to input key
    for j=1:4
        A=fir1(80,[2*fr(j)/Fs-2*80/Fs 2*fr(j)/Fs+2*80/Fs]);
        out=filter(A,1,signal);
        power(j)=rms(out);
    end
    [~,j]=max(power);
    y(j)=1;
    for j=1:4
        A=fir1(80,[2*fc(j)/Fs-2*80/Fs 2*fc(j)/Fs+2*80/Fs]);
        out=filter(A,1,signal);
        power(j)=rms(out);
    end
    [~,j]=max(power);
    y(j+4)=1;
    
    %decoder
    index=0;
    for j=1:4
        if(y(j))
            index=4*j-4;
        end
    end
    for j=1:4
        if(y(j+4))
            index=index+j;
        end
    end
    keys(i)=num2str(S(index));
end

keys=char(keys);