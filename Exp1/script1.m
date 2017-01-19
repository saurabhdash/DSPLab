clear;
clc;
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
t= 0:1/(40e4):3e-3;                                                        %Time array
x = square(2*pi*1e3*t);                                                    %Square Wave
t1 = 0:1/20e3:3e-3;                                                        %Time array
x1 = square(2*pi*1e3*t1);                                                  %Sampled Wave
plot(t,x);                                                                 %Plot
hold on;
stem(t1,x1);                                                               %Sampled Signal Plotted
xlabel('Time');                                                            %X-Axis Label
ylabel('x(t)');                                                            %Y-Axis Label
title('original and sampled square Wave');                                 %Plot title
ylim([-2, 2]);                                                             %Y Axis Limits
%% DFT of Square Wave
[dt,y] = DFTsqr(256,20);                                                   % DFT of the square Wave, 20kHz, 256 Samples
%% Reconstruction of the Signal from the DFT
figure;
recx = ifft(y); 
t = (0:size(recx,2)-1)*dt;
x = square(2*pi*1e3*t);
plot(t,recx);
error = x-recx;
error = sqrt(error*error')
%% Error Plotting for Different Sampling Rates
freqarr = 2:2:600;
err = zeros(size(freqarr,1),1);
for freq = freqarr
    [dt,y] = DFTsqr(256,freq);    
    recx = ifft(y); 
    t = (0:size(recx,2)-1)*dt;
    x = square(2*pi*1e3*t);
    error = x-recx;
    err(freq/2) = sqrt(error*error');
end
plot(freqarr*1e3, err);
xlabel('Frequency');
ylabel('Error');
title('Error vs Frequency');
%%

