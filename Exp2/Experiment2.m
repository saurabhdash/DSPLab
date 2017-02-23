clear;
clc;
%%
N = 513;
wc = 0.3*pi;
%%
hd = LPFilt(wc,N);
% plot(hd);
%%
w = rectWindow(N);
B1 = hd .* w;
figure;
freqz(B1,1,-0.9*pi:0.005:pi);
title(['Rectanguar Window (N=' num2str(N) ')']);
%%
w = triWindow(N);
B2 = hd .* w;
figure;
freqz(B2,1,-pi:0.005:pi);
title(['Trianguar Window (N=' num2str(N) ')']);
%%
w = hannWindow(N);
B3 = hd .* w;
figure;
freqz(B3,1,-pi:0.1:pi);
title(['Hanning Window (N=' num2str(N) ')']);
%%
w = hammWindow(N);
B4 = hd .* w;
figure;
freqz(B4,1,-pi:0.005:pi);
title(['Hamming Window (N=' num2str(N) ')']);
%%
w = blackWindow(N);
B5 = hd .* w;
figure;
freqz(B5,1,-pi:0.005:pi);
title(['Blackman Window (N=' num2str(N) ')']);
%%
Fs = 10 * 1e3;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 500;             % Length of signal
t = (0:L-1)*T;        % Time vector
x = sin(2*pi*0.1*Fs*t)+sin(2*pi*0.8*Fs*t);
%plot(t,x);
plotdft(x,Fs,'input FFT')
%%
y = filtfilt(B,1,x);
plotdft(y,Fs,'output FFT')