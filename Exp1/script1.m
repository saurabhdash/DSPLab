Fs = 12e3;
t=0:0.01*10^-3:(100-0.01)*10^-3;
t1 = 0:1/Fs:(100-0.01)*10^-3;
x=10*cos(2*pi*1e3*t)+6*cos(2*pi*2*1e3*t)+2*cos(2*pi*4*1e3*t);
x1=10*cos(2*pi*1e3*t1)+6*cos(2*pi*2*1e3*t1)+2*cos(2*pi*4*1e3*t1);
plot(t,x);
hold on;
stem(t1,x1);
xlabel('Time');
ylabel('x(t)');
title('original and sampled signal');
%{
figure;
y= circshift(abs(fft(x))/10000,[0 5000]);
plot([-50000:10:49999], y);
xlabel('Frequency');
ylabel('|X(f)|');
ylabel('|X(f)|/N');
title('DFT of original signal');
%}

DFT(10000,12);
DFT(64,12);
DFT(128,12);
DFT(256,12);

DFT(10000,8);

