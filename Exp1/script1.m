clear;
clc;
%{
%% Creating the Original Signal and Sampling at 12kHz
Fs = 12e3;                                                                 %Setting the Sampling Rate
t=0:0.01*10^-3:(100-0.01)*10^-3;                                           %Creating the time array for original signal
t1 = 0:1/Fs:(100-0.01)*10^-3;                                              %Creating the time 
x=10*cos(2*pi*1e3*t)+6*cos(2*pi*2*1e3*t)+2*cos(2*pi*4*1e3*t);              % Original Function
x1=10*cos(2*pi*1e3*t1)+6*cos(2*pi*2*1e3*t1)+2*cos(2*pi*4*1e3*t1);          % Sampled function
plot(t,x);                                                                 %Plotting the original function
hold on;
stem(t1,x1);                                                               %Plotting the sampled function
xlabel('Time');                                                            %X-Axis Label
ylabel('x(t)');                                                            %Y-Axis Label
title('original and sampled signal');                                      %Plot title
xlim([0.039, 0.0415]);
%% DFT of the Sampled Signal at 12kHz
DFT(10000,12);                                                             %Number of samples = 1e4 , Sampling Frequency = 12kHz
DFT(64,12);                                                                %Number of samples = 64 , Sampling Frequency = 12kHz
DFT(128,12);                                                               %Number of samples = 128 , Sampling Frequency = 12kHz
DFT(256,12);                                                               %Number of samples = 256 , Sampling Frequency = 12kHz
%% DFT of the Sampled Signal at frequencies lower than Nyquist Frequencies
DFT(10000,8);                                                              %Sampling Frequency = 8kHz, Number of samples = 1e4
DFT(10000,5);                                                              %Sampling Frequency = 5kHz, Number of samples = 1e4
DFT(10000,4);                                                              %Sampling Frequency = 4kHz, Number of samples = 1e4
%% Generating and Sampling a Square Wave
%}
t= 0:1/(40e4):3e-3;
x = square(2*pi*1e3*t);
ylim([-2,2]);
t1 = 0:1/20e3:3e-3;
x1 = square(2*pi*1e3*t1);
plot(t,x);
hold on;
stem(t1,x1); 
%% DFT of Square Wave
y = DFTsqr(256,20);
%% Reconstruction of the Signal from the DFT
figure;
x = ifft(y);
plot(x)