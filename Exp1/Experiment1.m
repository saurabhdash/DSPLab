clear;
clc;
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
[dt,y] = DFTsqr(256,20,'plot');                                            % DFT of the square Wave, 20kHz, 256 Samples
%% Reconstruction of the Signal from the DFT
figure;                                                                    %New Figure
recx = ifft(y);                                                            %Inverse DFT function 
t = (0:size(recx,2)-1)*dt;                                                 %Time Array
x = square(2*pi*1e3*t);                                                    %Generating Square Wave for Comparison
plot(t,recx);                                                              %Plotting the Reconstructed Signal
error = x-recx;                                                            
error = sqrt(error*error');                                                %RMS Error
%% Error Plotting for Different Sampling Rates
freqarr = 2:2:600;
err = zeros(size(freqarr,1),1);
for freq = freqarr
    [dt,y] = DFTsqr(256,freq,'noplot');    
    recx = ifft(y); 
    t = (0:size(recx,2)-1)*dt;
    x = square(2*pi*1e3*t);
    error = x-recx;
    err(freq/2) = sqrt(error*error');
end
semilogy(freqarr*1e3, err);
xlabel('Frequency');
ylabel('Error');
title('Error vs Frequency');

%% Sampling and effect of Nyquist Criteria
Fs = 12e3;                                                                 %Setting the Sampling Rate
t=0:0.01*10^-3:(100-0.01)*10^-3;                                           %Creating the time array for original signal
t1 = 0:1/Fs:(100-0.01)*10^-3;                                              %Creating the time 
x=10*cos(2*pi*1e3*t)+6*cos(2*pi*2*1e3*t)+2*cos(2*pi*4*1e3*t);              % Original Function
x1=10*cos(2*pi*1e3*t1)+6*cos(2*pi*2*1e3*t1)+2*cos(2*pi*4*1e3*t1);          % Sampled function at 12kHz
plot(t,x);                                                                 %Plotting the original function
hold on;
stem(t1,x1);                                                               %Plotting the sampled function
xlabel('Time');                                                            %X-Axis Label
ylabel('x(t)');                                                            %Y-Axis Label
title('original and sampled signal');                                      %Plot title
xlim([0.039, 0.0415]);
hold off

%sampling at different Fs
DFT(10000,12);
DFT(64,12);
DFT(128,12);
DFT(256,12);

DFT(10000,8);
DFT(64,8);
DFT(128,8);
DFT(256,8);

DFT(10000,5);
DFT(64,5);
DFT(128,5);
DFT(256,5);

DFT(10000,4);
DFT(64,4);
DFT(128,4);
DFT(256,4);
hold off

%reconstruction above Nyquist: 12KHz
ts = 0:1/12e3:(100-0.01)*10^-3;
xs=10*cos(2*pi*1e3*ts)+6*cos(2*pi*2*1e3*ts)+2*cos(2*pi*4*1e3*ts);
A=fir1(4,0.5,'low');
x_reconstruct1 = filter(A,1,xs);
%reconstruction below Nyquist: 5KHz
ts = 0:1/5e3:(100-0.01)*10^-3;
A=fir1(4,0.5,'low');
xs=10*cos(2*pi*1e3*ts)+6*cos(2*pi*2*1e3*ts)+2*cos(2*pi*4*1e3*ts);
x_reconstruct2 = filter(A,1,xs);

%% upsampling
xu=zeros(1,2399);
tu=0:1/(2*Fs):(100-0.05)*10^-3;
xu(1:2:2399)=x1(1:1200);
yu = (fft(xu,2399)/2399);
A = fir1(49,0.5,'low');
%{
figure
plot(abs(yu))
hold on
plot(abs(fft(upsample_reconstruct,2399)/2399));
hold off
%}
upsample_reconstruct=2*filter(A,1,xu);  %2 factor put to compensate for amplitude division in upsampling
figure
stem(t1,x1);
hold on
stem(tu,upsample_reconstruct);
hold off


%% downsampling
y1=(fft(x1,1200)/1200);
A = fir1(49,0.5,'low');
xfilt=filter(A,1,x1);

xd=xfilt(1:2:1199);
td=0:2/Fs:(100-0.05)*10^-3;
yd = fftshift(fft(xd,600)/600);
%%
audio;
%%