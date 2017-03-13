clear;
clc;
%% Definitions
f = [697 770 852  941 1209 1336 1447 1633];
S='123A456B789C*0#D';
Fs=8e3;
T=40e-3;
len=round(5+(30-5)*rand(1));        %sequence length between 5 and 30
sequence=datasample(S,len);         %random sequence of key presses
t=0:1/Fs:(len*Fs-1)*T/Fs;
Nt=T*Fs;
freq=(Fs/2)/Nt*(0:Nt-1);
y=zeros(1,8);
keys=zeros(1,len);
power=zeros(1,8);

%% DTMF Generator and Decoder
for i=1:len
    y(:)=0;
    signal=sumsinusoid(sequence,i,S,f,Fs);  %signal corresponding to input key
   
    for j=1:8
        A=fir1(95,[2*f(j)/Fs-20/Fs 2*f(j)/Fs+2*20/Fs]);
        out=filter(A,1,signal);
        power(j)=rms(out)^2;
    end
    [p1,j1]=max(power(1:4));
    y(j1)=1;
    [p2,j2]=max(power(5:8));
    j2=j2+4;
    y(j2)=1;
   
    if(p1+p2<0.75*sum(power))         %power criterion for valid detection
        y(:)=0;
    end
    
    % Goertzel algorithm for checking frequency deviation
    A=fir1(95,[2*f(j1)/Fs-20/Fs 2*f(j1)/Fs+2*20/Fs]);
    out=filter(A,1,signal);
    [~,f_est1]=max(goertzel(out,round(freq/Fs*Nt)+1));
    f_est1=freq(f_est1+1);
    A=fir1(95,[2*f(j2)/Fs-20/Fs 2*f(j2)/Fs+2*20/Fs]);
    out=filter(A,1,signal);
    [~,f_est2]=max(goertzel(out,round(freq/Fs*Nt)+1));
    f_est2=freq(f_est2+1);
    
    if(abs(f_est1-f(j1))>0.015*f(j1)||abs(f_est2-f(j2))>0.015*f(j2))
        y(:)=0;                  %frequency deviation criterion for valid detection
    end
    
    
    % Decoder
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
    
    
    if(index)
        keys(i)=num2str(S(index));
    else
        keys(i)='X';                    %in case of invalid detection
    end
end

keys=char(keys);