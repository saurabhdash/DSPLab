fr = [697 770 852  941];
fc = [1209 1336 1447 1633];
S='123A456B789C*0#D';
T=1;
t=0:T/10000:99999*T/10000;
y=zeros(1,8);
keys=zeros(1,10);

for i=1:10
    signal=sumsinusoid('4A*D8371*5',i,S,fr,fc);  %signal corresponding to input key
    for j=1:4
        A=fir1(100,[fr(j)/5000-0.01 fr(j)/5000+0.01]);
        out=filter(A,1,signal);
        y(j)=any(out>1);
    end
    for j=1:4
        A=fir1(100,[fc(j)/5000-0.01 fc(j)/5000+0.01]);
        out=filter(A,1,signal);
        y(j+4)=any(out>1);
    end
    %decoder
    for j=1:4
        if(y(j))index=4*j-4;
        end
    end
    for j=1:4
        if(y(j+4))index=index+j;
        end
    end
    keys(i)=num2str(S(index));
end
keys=char(keys);