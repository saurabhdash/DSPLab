clear;
clc;
%%
N = 32;
wc = 0.3*pi;
%%
hd = LPFilt(wc,N);
% plot(hd);
% ax = gca;
% ax.XLim = [1 N];
%%
w = rectWindow(N);
B = hd .* w;
figure;
freqz(B,1,-pi:0.1:pi);
title('Rectanguar Window');
%%
w = triWindow(N);
B = hd .* w;
figure;
freqz(B,1,-pi:0.1:pi);
title('Trianguar Window');
%%
w = hannWindow(N);
B = hd .* w;
figure;
freqz(B,1,-pi:0.1:pi);
title('Hanning Window');
%%
w = hammWindow(N);
B = hd .* w;
figure;
freqz(B,1,-pi:0.1:pi);
title('Hamming Window');
%%
w = blackWindow(N);
B = hd .* w;
figure;
freqz(B,1,-pi:0.1:pi);
title('Backmann Window');
%%
Fs = Fs * 1e3;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 10000;             % Length of signal
t = (0:L-1)*T;        % Time vector
%%
